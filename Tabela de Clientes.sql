
-- Tabela de Clientes 

create table analytics.tb_dim_customers as
select
	customer_unique_id as id_unico_cliente,
	-- O ID real e fixo do cliente
	customer_id as id_pedido_cliente,
	-- ID gerado a cada compra
	customer_city as cidade,
	-- Nome da cidade do cliente
	customer_state as estado,
	-- Sigla do estado (UF)
	customer_zip_code_prefix as cep_prefixo
	-- Os 5 primeiros dígitos do CEP
from
	stage.stg_customers
