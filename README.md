# ARIX Platform

[![Developed by Rabby IT Firm](https://img.shields.io/badge/Developed%20by-Rabby%20IT%20Firm-blue.svg)](https://github.com/rabbyitfirm)

**ARIX** is an advanced AI Agent & Workflow Orchestration Platform developed by Rabby IT Firm. It provides a complete suite of tools to build, manage, and scale AI-driven workflows and autonomous agents.

---

## 🌟 Key Features

- **A to Z Workflow Builder**: Visually design, construct, and orchestrate complex AI workflows and multi-step processes.
- **Agent Dashboard**: Monitor, configure, and manage autonomous AI agents in real time.
- **Vector Database Integration**: High-performance similarity search and retrieval-augmented generation (RAG) powered by Qdrant.
- **High-Performance Caching & Queues**: Low-latency execution powered by Redis.
- **Authentication & OAuth**: Integrated GitHub OAuth for secure user authentication and access control.
- **Automated OS Installation**: One-line auto-installer script for quick deployment.

---

## 🛠️ Architecture & Tech Stack

- **Frontend**: Next.js / Node.js
- **Backend API**: FastAPI / Python
- **Database**: PostgreSQL
- **Vector DB**: Qdrant (`localhost:6333`)
- **Cache / Message Queue**: Redis (`localhost:6379`)
- **Containerization**: Docker & Docker Compose

---

## 🚀 Quick Start & Installation

### Option 1: Automatic Installation (Recommended)

You can install ARIX automatically using the installer script:

```bash
curl -sSL https://raw.githubusercontent.com/rabbyitfirm/ARIX/main/scripts/install_arixos.sh | bash
```

### Option 2: Manual Installation via Docker Compose

1. **Clone the repository**:
   ```bash
   git clone https://github.com/rabbyitfirm/ARIX.git
   cd ARIX
   ```

2. **Configure Environment Variables**:
   Copy `.env.example` (or edit `.env`) and configure your credentials:
   ```bash
   cp .env.example .env
   ```
   *Make sure to set your `OPENAI_API_KEY`, `SECRET_KEY`, `GITHUB_ID`, and `GITHUB_SECRET` in `.env`.*

3. **Start Services using Docker Compose**:
   ```bash
   docker-compose -f infra/docker/docker-compose.yml up -d --build
   ```

---

## ⚙️ Environment Variables Configuration

The platform uses `.env` to configure all essential services:

| Variable | Description |
| --- | --- |
| `OPENAI_API_KEY` | OpenAI API Key for model inference |
| `POSTGRES_USER` | PostgreSQL Username (default: `postgres`) |
| `POSTGRES_PASSWORD` | PostgreSQL Password |
| `POSTGRES_DB` | PostgreSQL Database name (default: `arix`) |
| `DATABASE_URL` | PostgreSQL Connection String |
| `REDIS_URL` | Redis Connection URL (`redis://redis:6379`) |
| `QDRANT_URL` | Qdrant Vector DB Endpoint (`http://qdrant:6333`) |
| `SECRET_KEY` | JWT Secret Key for token generation |
| `GITHUB_ID` | GitHub OAuth Client ID |
| `GITHUB_SECRET` | GitHub OAuth Client Secret |

---

## 🌐 Service Access Points

Once running, the services are accessible at the following endpoints:

- **Frontend Application**: `http://localhost:3000`
- **Backend API**: `http://localhost:8000`
- **API Documentation**: `http://localhost:8000/docs`
- **Database**: PostgreSQL at `localhost:5432`
- **Vector Database**: Qdrant at `localhost:6333`
- **Cache**: Redis at `localhost:6379`

---

## 🛠️ Management Commands

Common operational commands for Docker Compose:

- **View Logs**:
  ```bash
  docker-compose -f infra/docker/docker-compose.yml logs -f
  ```
- **Stop Platform**:
  ```bash
  docker-compose -f infra/docker/docker-compose.yml down
  ```
- **Restart Services**:
  ```bash
  docker-compose -f infra/docker/docker-compose.yml restart
  ```
- **Update & Rebuild**:
  ```bash
  git pull origin main
  docker-compose -f infra/docker/docker-compose.yml up -d --build
  ```

---

## 📞 Support & Community

- **Repository**: [github.com/rabbyitfirm/ARIX](https://github.com/rabbyitfirm/ARIX)
- **Issues**: [GitHub Issues](https://github.com/rabbyitfirm/ARIX/issues)
- **Documentation & Wiki**: [ARIX Wiki](https://github.com/rabbyitfirm/ARIX/wiki)
- **Contact Support**: support@rabbyitfirm.com
