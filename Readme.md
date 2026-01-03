# 🚀 DeltaHook
### Transform any legacy REST API into a real-time Webhook provider.

**DeltaHook** is a high-performance developer infrastructure tool that bridges the gap between static "pull-based" legacy systems and modern "event-driven" architectures. It monitors specific JSON fields in third-party APIs and fires a webhook only when a meaningful change is detected.

---

## 🛠 The Problem
Many enterprise systems (ERPs, old FinTech APIs, Inventory Managers) do not support webhooks. Developers are forced to write expensive "polling" scripts that:
1. **Waste Server Resources:** Making 1,000 calls just to find 1 change.
2. **Increase Latency:** Waiting for the next "cron job" to find out a payment was made.
3. **Hit Rate Limits:** Polling too fast can get your IP banned.

## ✅ The Solution
DeltaHook acts as a distributed "watcher." You tell DeltaHook what to watch, and it handles the polling, diffing, and event delivery for you. Your backend remains clean—simply waiting for a `POST` request when data actually changes.

---

## ✨ Key Features
- **Field-Level Diffing:** Use JSONPath to watch specific nested fields (e.g., `$.order.status`).
- **Distributed Scaling:** Powered by BullMQ and Redis to handle thousands of concurrent polls.
- **Smart Retries:** Exponential backoff for failed webhook deliveries.
- **Secrets Vault:** AES-256-CBC encrypted storage for your legacy API keys.
- **Developer Dashboard:** Real-time logs for every poll and every webhook fired.

---

## 🏗 Architecture



1. **API Server:** Handles user management and job configuration.
2. **Redis Queue:** Manages the timing and distribution of polling tasks via BullMQ.
3. **Workers:** Independent nodes that fetch data from the source, compare hashes, and trigger webhooks.
4. **State Store:** PostgreSQL keeps track of the "Last Known Value" to prevent duplicate triggers.

---

## 💻 Tech Stack
- **Frontend:** React.js, Tailwind CSS, TanStack Query
- **Backend:** Node.js (TypeScript), Express.js
- **Database:** PostgreSQL + Prisma ORM
- **Queue/Task Management:** Redis + BullMQ
- **Security:** Crypto (AES-256-CBC), Argon2 (Password hashing)

---


## 🚀 Getting Started

### Prerequisites
- Node.js (v18+)
- PostgreSQL
- Redis

### Installation
1. **Clone the repo**

2. **Install Dependencies**

3. **Environment Setup Create a .env file in the root:**

```bash
DATABASE_URL="postgresql://user:password@localhost:5432/deltahook"
REDIS_URL="redis://localhost:6379"
MASTER_KEY="your-32-character-secret-key-here"
JWT_SECRET="your-jwt-secret"
```

4. **Prisma Setup** 

```Bash
npx prisma migrate dev --name init
npx prisma generate
Start Development Server
```

## 🔒 Security
DeltaHook is built for enterprise-grade security:

Separation of Concerns: Identity (Users) is separated from Credentials (API Keys).

At-Rest Encryption: External API keys are never stored in plain text.

Isolation: Workers only access the specific credentials required for the current job.

## 📜 License
Distributed under the MIT License. See LICENSE for more information.

---
