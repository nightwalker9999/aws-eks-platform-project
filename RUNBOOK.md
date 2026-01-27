# Runbook

## Deployment
1. Apply Terraform infrastructure
2. Deploy Kubernetes base components
3. Deploy application via Helm
4. Validate rollout

## Rollback
- kubectl rollout undo deployment/app

## Debugging
- kubectl get pods
- kubectl describe pod <pod>
- kubectl logs <pod>

## Common Issues
- Ingress not routing traffic
- Pods crashing on startup
- CI/CD pipeline failures

## Alerts & Responses
- High CPU: scale replicas
- Pod crashloop: rollback deployment

## Disaster Recovery
- Reapply Terraform
- Redeploy Helm charts

