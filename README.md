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
