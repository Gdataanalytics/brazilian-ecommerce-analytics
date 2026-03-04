


-- Criando a tabela Fato de avaliacoes de clientes no Schema Analytics com nomes em português
CREATE TABLE analytics.tb_fat_order_reviews AS
SELECT 
    review_id AS id_avaliacao,
    order_id AS id_pedido,
    review_score AS nota_pontuacao,
    
    -- Tradução e tratamento de textos
    COALESCE(review_comment_title, 'Sem título') AS titulo_comentario,
    COALESCE(review_comment_message, 'Sem comentário') AS mensagem_comentario,
    
    -- Conversão de tipos de data
    CAST(review_creation_date AS TIMESTAMP) AS data_criacao_avaliacao,
    CAST(review_answer_timestamp AS TIMESTAMP) AS data_resposta_vendedor,
    
    -- Métrica de engajamento para o Cluster
    CASE 
        WHEN review_comment_message IS NOT NULL THEN 1 
        ELSE 0 
    END AS fl_cliente_engajado

FROM stage.stg_order_reviews