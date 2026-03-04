-- Criando a tabela de produtos

CREATE TABLE analytics.tb_dim_products AS
SELECT 
    p.product_id AS id_produto,
    
    -- Tradução e tratamento do nome da categoria
    COALESCE(p.product_category_name, 'não informado') AS categoria_nome,
    
    -- Características físicas (úteis para calcular frete no futuro)
    p.product_weight_g AS peso_gramas,
    p.product_length_cm AS comprimento_cm,
    p.product_height_cm AS altura_cm,
    p.product_width_cm AS largura_cm,
    
    -- Quantidade de fotos (pode ser um insight: produtos com mais fotos vendem mais?)
    COALESCE(p.product_photos_qty, 0) AS qtd_fotos

FROM stage.stg_products p
