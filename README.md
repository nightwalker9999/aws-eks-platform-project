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

