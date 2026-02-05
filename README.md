# AWS EKS Production Platform

## Problem Statement
Modern teams need a repeatable, scalable, and reliable platform to deploy microservices with automated infrastructure, CI/CD, and observability.

## Solution Overview
This project implements a production-grade Kubernetes platform on AWS EKS using Terraform for infrastructure, Jenkins/GitHub Actions for CI/CD, and Prometheus/Grafana for observability.

## Tech Stack
- Cloud: AWS
- IaC: Terraform
- Container: Docker
- Orchestration: Kubernetes (EKS simulation)
- CI/CD: GitHub Actions
- GitOps: Helm
- Monitoring: Prometheus, Grafana

## Architecture
See ARCHITECTURE.md for system design.

## Key Features
- Modular Terraform infrastructure
- Remote state and locking
- Kubernetes autoscaling
- Zero-downtime deployments
- CI/CD automation
- Observability and alerting

## CI/CD Flow
1. Code commit
2. CI pipeline runs tests and builds Docker image
3. Image pushed to registry
4. Helm deploy triggered
5. Kubernetes rollout validated

## How to Run
Steps will be added as the project progresses.

## What I Learned
This section will capture real-world DevOps learnings during implementation.

#### Terraform + LocalStack — Issues & Fixes (Quick Notes)

- **AWS credential error during `terraform plan`**  
  Cause: Terraform tried real AWS creds / IMDS  
  Fix: Configure AWS provider only in root module with LocalStack endpoints + dummy creds

- **Duplicate provider configuration**  
  Cause: `provider "aws"` defined in multiple files  
  Fix: Keep provider config in one place (`provider.tf` in root)

- **Undeclared variable error**  
  Cause: Variable declared only in module, not in root  
  Fix: Declare variables separately in root and module, pass explicitly

- **`terraform output` shows nothing**  
  Cause: Outputs defined only inside module  
  Fix: Re-export required outputs in root `outputs.tf`

- **Outputs added after infra creation**  
  Cause: Outputs were introduced later  
  Fix: Run `terraform apply -refresh-only` to sync state

- **LocalStack port 4566 already in use**  
  Cause: LocalStack already running  
  Fix: Reuse existing container, verify with `docker ps`

## K8s Demo (Playground)

### Deploy

```bash
kubectl apply -f k8s/base/app.yaml
kubectl apply -f k8s/base/service.yaml
kubectl apply -f k8s/base/ingress.yaml
```

### Install ingress-nginx

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
kubectl -n ingress-nginx rollout status deploy/ingress-nginx-controller
```

### Verify

```bash
kubectl get deploy,svc,ingress
kubectl -n ingress-nginx get svc ingress-nginx-controller
```

### Test (NodePort)

```bash
IP=$(kubectl get node controlplane -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}')
PORT=$(kubectl -n ingress-nginx get svc ingress-nginx-controller -o jsonpath='{.spec.ports[0].nodePort}')
curl -H "Host: web.demo.local" http://$IP:$PORT | head
```

