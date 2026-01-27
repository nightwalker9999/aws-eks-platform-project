# Architecture Overview

## System Components
- VPC
- EKS Cluster
- Node Groups
- Ingress Controller
- Application Pods
- CI/CD Pipeline
- Monitoring Stack

## Data Flow
User → Ingress → Service → Pod → Response

## Deployment Flow
Git Commit → CI → Docker → Registry → Helm → Kubernetes

## Scaling Flow
Traffic → HPA → Pod Scaling → Node Scaling

## Security
- IAM roles for service accounts (IRSA)
- Secrets management
- Network isolation

## Observability
- Prometheus metrics
- Grafana dashboards
- Alert rules

## Failure Scenarios
- Pod failure
- Node failure
- Bad deployment

