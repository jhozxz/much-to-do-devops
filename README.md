# MuchTodo Containerization & Orchestration

This repository contains the containerization and Kubernetes deployment configuration for the "MuchTodo" Golang backend application.

## 📂 Project Structure

```text
container-assessment/
├── Dockerfile              # Multi-stage build for Golang API
├── docker-compose.yml      # Local development setup
├── kubernetes/             # K8s Manifests
│   ├── mongodb/            # Database resources (Stateful)
│   ├── backend/            # Application resources (Stateless)
│   └── ingress.yaml        # External access configuration
├── scripts/                # Automation scripts
└── evidence/               # Screenshots of deployment verification

Phase 1: Docker Local Development
Prerequisites
Docker & Docker Compose installed

Instructions
Build the image:

Bash

./scripts/docker-build.sh
Run the application (and MongoDB):

Bash

./scripts/docker-run.sh
Verify Access:

API Health: http://localhost:8080/health

MongoDB is running on port 27017.

☸️ Phase 2: Kubernetes Deployment (Kind)
Prerequisites
Kind (Kubernetes in Docker)

Kubectl

Setup Cluster
We use a custom Kind configuration to map ports for Ingress and NodePort visibility on the host.

Create Cluster:

Bash

kind create cluster --name muchtodo-cluster --config kind-config.yaml
Install Nginx Ingress Controller:

Bash

kubectl apply -f [https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml](https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml)
Deployment
Deploy Application:

Bash

./scripts/k8s-deploy.sh
This script loads the local Docker image into Kind and applies all manifests.

Verify Status:

Bash

kubectl get pods -n much-to-do-ns
Access Application:

Via NodePort: http://localhost:30080/health

Via Ingress: http://localhost/health

🔐 Configuration Details
Database Credentials
User: admin

Password: password

Database: muchtodo

Environment Variables
The application connects via the connection string stored in backend-secret.yaml: mongodb://admin:password@mongodb-service:27017/muchtodo?authSource=admin

🧹 Cleanup
To remove all resources:

Bash

./scripts/k8s-cleanup.sh

---

### **Step 2: Generate the Missing Secret (Crucial)**

In my previous response, I gave you the placeholder for `backend-secret.yaml`. You must generate the valid Base64 string for the connection string to work in Kubernetes.

Run this command in your Kali terminal:

```bash
echo -n "mongodb://admin:password@mongodb-service:27017/muchtodo?authSource=admin" | base64
Copy the output string and update your kubernetes/backend/backend-secret.yaml file:

YAML

apiVersion: v1
kind: Secret
metadata:
  name: backend-secret
  namespace: much-to-do-ns
type: Opaque
data:
  # Paste the output string below
  mongo-uri: <PASTE_YOUR_BASE64_STRING_HERE>
Step 3: Gather Evidence
Before pushing to GitHub, you must populate the evidence/ folder. The assessment specifically asks for screenshots.

Take Screenshots of:

docker-compose ps showing containers running.

kind get clusters showing your cluster.

kubectl get all -n much-to-do-ns showing pods running.

A browser or curl command showing the /health endpoint responding {"status":"ok"}.

Save them into the container-assessment/evidence/ folder (e.g., docker_run.png, k8s_pods.png).
