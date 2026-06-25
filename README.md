# Books — Secure Cloud Native Computing

CIS3111 Cloud Computing Assignment

## What this project is about

This project migrates the **Books** online library service from a stand-alone Docker setup to a fully managed, secure Kubernetes deployment, in three stages:

1. **Task 1 — Current deployment**
   Run the Books app and PostgreSQL in two separate Docker containers, replicating the existing stand-alone setup. Tested using Postman against the Swagger/OpenAPI endpoints.

2. **Task 2 — Kubernetes deployment**
   Migrate the setup to Minikube using Helm. Deploys PostgreSQL (Bitnami chart), the original Books app, and a read-only Books variant, with traffic split 1:4 between them.

3. **Task 3 — High-availability database cluster**
   Replace the single PostgreSQL instance with a split read-write/read-only cluster using CloudNativePG (CNPG). The original Books app connects to the rw database, the read-only variant connects to the ro database.

## Structure

\`\`\`
.
├── Task1
├── Task2
└── Task3
\`\`\`

Each task folder contains its own setup files, automation scripts, and a `readme.txt` with step-by-step instructions to replicate that part of the solution.

## Tools used

- Docker
- Kubernetes (Minikube)
- Helm
- CloudNativePG (CNPG)
- Postman
