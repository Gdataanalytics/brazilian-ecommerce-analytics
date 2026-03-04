# Brazilian E-Commerce Analytics - G Analytics & Data

Este projeto foca na clusterização de clientes utilizando a base da Olist.

## 🛠️ Etapa 1: Ingestão de Dados
Construímos um pipeline em Python (`ingestao.py`) que:
1. Baixa os dados do Kaggle automaticamente.
2. Carrega para o PostgreSQL no schema `stage`.
3. Limpa os arquivos temporários.

### Tecnologias:
- Python (Pandas, SQLAlchemy)
- PostgreSQL

## 🛠️ Etapa 2: Transformação e Modelagem (Analytics)
Processamos os dados brutos do schema `stage` para o schema `analytics`, estruturando um **Star Schema** focado em performance para o modelo de Machine Learning.

### Ações Realizadas:
- **Tratamento de Nulos:** Gestão de campos vazios em datas e métricas de entrega.
- **Feature Engineering:** Criação de colunas de performance como `dias_para_entrega` e `dias_atraso`.
- **Padronização:** Tradução de status e categorias para o português.
- **Arquitetura de Dados:** Separação entre tabelas de Fato (eventos) e Dimensões (características).

**Tabelas de Fato (Eventos):**
- `tb_fat_orders`: Cabeçalho do pedido com status e cronograma.
- `tb_fat_order_items`: Detalhamento de itens, preços e fretes por pedido.
- `tb_fat_order_payments`: Registros de transações e métodos de pagamento.
- `tb_fat_order_reviews`: Notas e avaliações de satisfação do cliente.

**Tabelas de Dimensão (Contexto):**
- `tb_dim_customers`: Cadastro e identificação única dos clientes.
- `tb_dim_products`: Atributos físicos e categorias dos produtos.
- `tb_dim_sellers`: Dados de origem dos vendedores.
- `tb_dim_geolocation`: Base de geolocalização por prefixo de CEP.

### Tecnologias:
- SQL (PostgreSQL)
- DBeaver (Gestão do DW)

### 📊 Modelo de Dados (Star Schema)
Abaixo está o diagrama de relacionamento das 8 tabelas modeladas no schema `analytics`. Este modelo foi desenhado seguindo a metodologia **Star Schema** para otimizar as consultas e facilitar a análise exploratória dos dados.

![Diagrama de Relacionamento](img/diagrama%20schema.png)