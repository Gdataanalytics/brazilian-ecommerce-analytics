

-- Cração da tabela de pedidos 

CREATE TABLE analytics.tb_fat_orders AS
SELECT 
    order_id AS id_pedido,
    customer_id AS id_cliente_pedido,
    
    -- Tradução de Status (Simples mapeamento)
    CASE 
        WHEN order_status = 'delivered' THEN 'entregue'
        WHEN order_status = 'shipped' THEN 'enviado'
        WHEN order_status = 'canceled' THEN 'cancelado'
        ELSE order_status 
    END AS status_pedido,
    
    CAST(order_purchase_timestamp AS TIMESTAMP) AS data_compra,
    CAST(order_delivered_customer_date AS TIMESTAMP) AS data_entrega_real,
    CAST(order_estimated_delivery_date AS TIMESTAMP) AS data_entrega_estimada,
    
    -- Cálculo de Performance (Importante para o Cluster)
    DATE_PART('day', CAST(order_delivered_customer_date AS TIMESTAMP) - CAST(order_purchase_timestamp AS TIMESTAMP)) AS dias_para_entrega,
    
    -- Se o valor for positivo, houve atraso
    DATE_PART('day', CAST(order_delivered_customer_date AS TIMESTAMP) - CAST(order_estimated_delivery_date AS TIMESTAMP)) AS dias_atraso

FROM stage.stg_orders