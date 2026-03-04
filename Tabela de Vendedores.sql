

-- Criando a tabela vendedores

CREATE TABLE analytics.tb_dim_sellers AS
SELECT 
    seller_id AS id_vendedor,
    seller_zip_code_prefix AS cep_vendedor,
    seller_city AS cidade_vendedor,
    seller_state AS uf_vendedor
FROM stage.stg_sellers