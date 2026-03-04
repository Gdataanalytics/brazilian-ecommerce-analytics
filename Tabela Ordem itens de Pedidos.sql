

-- Criando a tabela de itens pedidos (ordem de pedidos)

create table analytics.tb_fat_order_items as
select
	order_id as pedido_id,
	order_item_id as item_sequencial,
	-- O "contador" que torna a linha única
	product_id as produto_id,
	seller_id as vendedor_id,
	shipping_limit_date as data_limite_envio,
	price as valor_item,
	freight_value as valor_frete,
	(price + freight_value) as valor_total_item
	-- O que o cliente pagou de fato pelo item (item + frete)
from
	stage.stg_order_items

/* NOTA DE APRENDIZADO:
Esta é uma tabela de FATO. Ela não possui linhas duplicadas porque o 'order_item_id' 
garante a unicidade de cada item dentro de um mesmo pedido. 
*/
