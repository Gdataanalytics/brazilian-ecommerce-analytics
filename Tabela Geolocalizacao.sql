
-- Criando a tabela de dimensão de geolocalização consolidada
CREATE TABLE analytics.tb_dim_geolocation AS
SELECT 
 -- Chave de ligação com a tabela de clientes para atribuir localização ao perfil de consumo
    geolocation_zip_code_prefix AS cep_prefixo, 
    -- Coordenada Norte-Sul: Permite ao algoritmo calcular distâncias físicas e polos regionai
    AVG(geolocation_lat) AS latitude, 
      -- Coordenada Leste-Oeste: Essencial para identificar "manchas" de calor e densidade logística
    AVG(geolocation_lng) AS longitude, 
    -- Pegamos o MAX da cidade e do estado para garantir que venha apenas 1 valor por CEP
    MAX(
        TRANSLATE(
            UPPER(TRIM(geolocation_city)), 
            'ÁÉÍÓÚÂÊÎÔÛÃÕÀÈÌÒÙÄËÏÖÜÇ', 
            'AEIOUAEIOUAOAEOIUAEIOUC'
        )
    ) AS cidade,
    MAX(geolocation_state) AS estado -- MAX aqui para não precisar agrupar por estado
FROM stage.stg_geolocation
GROUP BY 1 -- AGRUPAR APENAS PELO PREFIXO DO CEP


    
 /* POR QUE USAMOS AVG (MÉDIA) NAS COORDENADAS? 
Um único prefixo de CEP possui múltiplos registros de latitude/longitude na base original. 
O uso do AVG é fundamental para gerar um único ponto geográfico (centroide) por CEP, 
eliminando ruídos e impedindo que o JOIN duplique registros de clientes, o que 
invalidaria os cálculos de faturamento e frequência do algoritmo de clusterização.
*/