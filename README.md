# 🚀 ARIX: Autonomous AI Operating System

**ARIX** is an **AI-native cloud operating system** developed by **Rabby IT Firm** that manages **agents, workflows, memory, automation, and intelligence** from A to Z. It enables **creators, developers, and businesses** to build, automate, and scale **autonomous AI workflows** without manual intervention.

![ARIX Dashboard](https://via.placeholder.com/800x400?text=ARIX+Dashboard+Preview)

---

## ✨ Features
- **A to Z Workflow Builder**: Drag-and-drop interface for designing **end-to-end AI workflows**.
- **Multi-Agent Collaboration**: Agents work together to execute complex tasks (e.g., SEO, DevOps, Content).
- **Memory System**: Short-term, long-term, and knowledge memory for context retention.
- **Tool Integration**: Connect to **Google, GitHub, WordPress, Slack, and more**.
- **Prevention Layer**: **RBAC, rate limiting, sandboxing, and moderation** for security.
- **Marketplace**: Install and share **pre-built agents and workflows**.
- **Autonomous Mode**: Agents can **self-plan, retry, debug, and improve** workflows.

---

## 🏗️ Architecture
ARIX consists of:
1. **Frontend**: Next.js + React Flow + shadcn/ui (A to Z Workflow Builder + Agent Dashboard).
2. **Backend**: FastAPI + PostgreSQL + Redis + Qdrant (Workflow Engine + Agent Runtime).
3. **AI Layer**: LangGraph + LiteLLM + Ollama (Multi-Agent Orchestration).
4. **Infrastructure**: Docker + Kubernetes + Cloudflare (Scalable Deployment).

![ARIX Architecture](docs/architecture-diagram.png)

---

## 🛠️ Quick Start
### Prerequisites
- Docker + Docker Compose
- Node.js 18+ (for local frontend development)
- Python 3.9+ (for local backend development)
- Git

### Option 1: Auto-Installer (Recommended)
Run the following command to **automatically install and start ARIX**:
```bash
curl -sSL https://raw.githubusercontent.com/rabbyitfirm/ARIX/main/scripts/install_arixos.sh | bash