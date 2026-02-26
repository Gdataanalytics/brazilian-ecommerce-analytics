import kagglehub
import pandas as pd
import os
import shutil
from sqlalchemy import create_engine

# --- CONFIGURAÇÕES DE ACESSO (Preenchido com seus dados) ---
USUARIO = 'postgres'
SENHA = 
HOST = 'localhost'
PORTA = 
BANCO = 

# Criando a engine de conexão com o Postgres
engine = create_engine(f'postgresql://{USUARIO}:{SENHA}@{HOST}:{PORTA}/{BANCO}')

print("--- [INICIANDO PIPELINE] G Analytics & Data ---")

try:
    # 1. Download temporário dos arquivos do Kaggle
    print("📥 Baixando arquivos do Kaggle...")
    path = kagglehub.dataset_download("olistbr/brazilian-ecommerce")
    arquivos = [f for f in os.listdir(path) if f.endswith('.csv')]

    # 2. Loop de carga para o Banco (Schema Stage)
    print(f"✅ {len(arquivos)} arquivos encontrados. Iniciando carga no banco...")
    
    for arquivo in arquivos:
        caminho_completo = os.path.join(path, arquivo)
        
        # Limpando o nome da tabela para o padrão stg_nome
        nome_tabela = 'stg_' + arquivo.replace('.csv', '').replace('_dataset', '').replace('olist_', '')
        
        print(f"🚀 Enviando: {nome_tabela}...")
        
        # Lê o CSV e envia para o Postgres
        df = pd.read_csv(caminho_completo)
        df.to_sql(nome_tabela, engine, schema='stage', if_exists='replace', index=False)

    # 3. LIMPEZA AUTOMÁTICA DO PC
    print("\n🧹 Limpando arquivos temporários do seu computador...")
    shutil.rmtree(path, ignore_errors=True)

    print("\n✨ SUCESSO ABSOLUTO! Dados carregados e máquina limpa.")
    print("Pode conferir no pgAdmin dentro do seu schema 'stage'.")

except Exception as e:
    print(f"\n❌ Ocorreu um erro: {e}")
