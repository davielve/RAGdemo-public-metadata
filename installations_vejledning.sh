  #!/bin/bash

# Installationsvejledning for RAG-demo
# Dette script indeholder de kommandoer, der er brugt til at sætte miljøet op.

echo "Starter installation af RAG-demo infrastruktur..."

# 1. Opret nødvendige mapper til volumener
mkdir -p n8n_data postgres_data chroma_data ollama_data knowledge_base
sudo chown -R 1000:1000 n8n_data knowledge_base

# 2. Start containerne via Docker Compose
sudo docker compose up -d

# 3. Download AI modeller
echo "Downloader modeller til Ollama..."
sudo docker exec -it rag_ollama ollama pull command-r
sudo docker exec -it rag_ollama ollama pull bge-m3

echo "Installation færdig!"

