
-- Criando a tabela de dimensão de geolocalização consolidada
CREATE TABLE analytics.tb_dim_geolocation AS
SELECT 
    -- Chave de ligação com a tabela de clientes para atribuir localização ao perfil de consumo
    geolocation_zip_code_prefix AS cep_prefixo, 

    -- Coordenada Norte-Sul: Permite ao algoritmo calcular distâncias físicas e polos regionais
    AVG(geolocation_lat) AS latitude, 

    -- Coordenada Leste-Oeste: Essencial para identificar "manchas" de calor e densidade logística
    AVG(geolocation_lng) AS longitude, 

    -- Nome da localidade: Usado para rotular e interpretar os clusters (ex: "Cluster de Capitais")
    -- TRATAMENTO DA CIDADE:
    -- 1. TRIM e UPPER padronizam o formato.
    -- 2. TRANSLATE troca caracteres acentuados pelos equivalentes simples.
    -- 3. MAX consolida tudo em uma única linha por CEP.
    MAX(
        TRANSLATE(
            UPPER(TRIM(geolocation_city)), 
            'ÁÉÍÓÚÂÊÎÔÛÃÕÀÈÌÒÙÄËÏÖÜÇ', 
            'AEIOUAEIOUAOAEOIUAEIOUC'
        )
    ) AS cidade,

    -- Sigla da UF: Permite validar se o agrupamento faz sentido em uma escala macro (estadual)
    geolocation_state AS estado 

FROM stage.stg_geolocation
GROUP BY 
    1, 5

    
 /* POR QUE USAMOS AVG (MÉDIA) NAS COORDENADAS? 
Um único prefixo de CEP possui múltiplos registros de latitude/longitude na base original. 
O uso do AVG é fundamental para gerar um único ponto geográfico (centroide) por CEP, 
eliminando ruídos e impedindo que o JOIN duplique registros de clientes, o que 
invalidaria os cálculos de faturamento e frequência do algoritmo de clusterização.
*/