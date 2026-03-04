
-- Criando a tabela de pagamentos
 
 CREATE TABLE analytics.tb_fat_order_payments AS
SELECT 
    order_id AS pedido_id,
    
    payment_sequential AS pagamento_sequencial,
    -- Identifica se houve mais de uma forma de pagamento para o mesmo pedido.

    payment_type AS tipo_pagamento,
    -- Cartão, boleto, voucher, etc. (Ponto importante para criar perfis de cluster).

    payment_installments AS qtd_parcelas,
    -- Quantidade de vezes que o cliente parcelou.

    payment_value AS valor_pagamento
    -- O valor total pago nesta transação específica.

FROM stage.stg_order_payments

/* NOTA DE APRENDIZADO (FATO):
Esta tabela é uma Fato porque registra as transações financeiras. 
O 'valor_pagamento' nesta tabela deve bater com o 'valor_total' do pedido 
quando somarmos todas as formas de pagamento de um mesmo pedido_id.
*/