# RAGdemo - Lokalt Juridisk RAG-System

Dette projekt er en komplet, lokal løsning til Retrieval-Augmented Generation (RAG), designet til at analysere og besvare spørgsmål baseret på komplekse lovtekster (som GDPR).

## 🚀 Funktionalitet
*   **Lokal AI:** Alt kører lokalt via Docker. Ingen data sendes til skyen.
*   **Avanceret Ingestion:** Dokumenter splittes semantisk og gemmes med rige metadata (f.eks. artikel-numre og kapitler).
*   **Smart Retrieval:** Systemet bruger metadata-filtrering til at identificere præcise afsnit. Når en relevant vektor findes, hentes hele det tilhørende afsnit/artikel for at give AI'en fuld kontekst.
*   **Dansk Sprogstøtte:** Optimeret til dansk jura med modeller, der forstår kontekst og fagudtryk.

## 🛠 Teknologi-stack
*   **Orkestrering:** [n8n](https://n8n.io/) (Workflows til indtagelse og chat-interface).
*   **LLM:** `command-r` (Optimeret til RAG og lange kontekster).
*   **Embeddings:** `bge-m3` (Multilinguual model med høj præcision til dansk).
*   **Vektor Database:** [ChromaDB](https://www.trychroma.com/).
*   **Model Hosting:** [Ollama](https://ollama.ai/).
*   **Database:** PostgreSQL (Til n8n historik og metadata).

## 📁 Struktur
*   `workflows/`: n8n JSON-filer til import (Ingestion og Chat).
*   `knowledge_base/`: Mappen hvor lovtekster (txt/md) placeres før indtagelse.
*   `prompts/`: System-prompts brugt til at styre AI'ens persona (Senior IT-arkitekt).
*   `rapport/`: Projektdokumentation og fasebeskrivelser.

## ⚙️ Installation
1.  Kør `bash installations_vejledning.sh` for at opsætte mapper og starte Docker.
2.  Importer workflows fra `workflows/` mappen ind i n8n.
3.  Log ind i n8n på `http://localhost:5678` og kør "RAG Ingestion" workflowet for at indeksere dine dokumenter.

## 🧠 Metadata & Retrieval Logik
Systemet benytter en "Parent-Document" inspireret tilgang:
1.  Under **Ingestion** bliver teksten opdelt i artikler/kapitler, og metadata (artikel_nr, kapitel) knyttes til hver bid.
2.  Under **Retrieval** søger systemet i ChromaDB. Når et match findes, sikrer metadata-filtreringen, at AI'en præsenteres for den fulde artikel, hvilket minimerer risikoen for "halve" svar eller manglende kontekst.
