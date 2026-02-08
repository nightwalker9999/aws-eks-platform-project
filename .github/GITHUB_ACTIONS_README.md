# GitHub Actions CI/CD Setup

This repository includes automated CI/CD workflows for validating, building, and testing the AWS EKS platform project.

## 📋 Available Workflows

### 1. Terraform Validation
**File:** `.github/workflows/terraform-validate.yml`

**Triggers:**
- Push to `main` or `develop` branches (when terraform files change)
- Pull requests to `main` (when terraform files change)

**What it does:**
- Validates Terraform syntax
- Checks code formatting with `terraform fmt`
- Runs `terraform init` and `terraform validate`
- Comments on PRs if validation fails

**Status Badge:**
```markdown
![Terraform Validation](https://github.com/nightwalker9999/aws-eks-platform-project/actions/workflows/terraform-validate.yml/badge.svg)
```

---

### 2. Kubernetes Manifest Validation
**File:** `.github/workflows/k8s-validate.yml`

**Triggers:**
- Push to `main` or `develop` (when k8s files change)
- Pull requests to `main` (when k8s files change)

**What it does:**
- Validates YAML syntax with `kubectl --dry-run`
- Runs `kubeval` to check manifest validity
- Checks for deprecated Kubernetes APIs

---

### 3. Docker Build and Push
**File:** `.github/workflows/docker-build.yml`

**Triggers:**
- Push to `main` (when app files change)
- Manual trigger via `workflow_dispatch`

**What it does:**
- Builds Docker image from `app/` directory
- Tags with branch name, commit SHA, and `latest`
- Pushes to GitHub Container Registry (ghcr.io)
- Uses layer caching for faster builds

**Accessing the image:**
```bash
docker pull ghcr.io/nightwalker9999/aws-eks-platform-project/nginx-app:latest
```

---

### 4. Local Infrastructure Test
**File:** `.github/workflows/local-test.yml`

**Triggers:**
- Manual trigger via `workflow_dispatch` (Click "Run workflow")
- Push to `main` (when terraform/k8s/app files change)

**What it does:**
1. ✅ Creates Kind cluster (local Kubernetes)
2. ✅ Starts LocalStack (AWS emulator)
3. ✅ Validates Terraform configuration
4. ✅ Builds Docker image
5. ✅ Deploys all K8s manifests
6. ✅ Verifies deployment
7. ✅ Tests application
8. ✅ Cleans up resources

**This workflow demonstrates:**
- Infrastructure as Code testing
- Local AWS simulation (no costs!)
- Complete deployment pipeline
- Kubernetes cluster management
- CI/CD best practices

---

## 🚀 How to Use

### Setup (One-time)

1. **Clone the repository**
   ```bash
   git clone https://github.com/nightwalker9999/aws-eks-platform-project.git
   cd aws-eks-platform-project
   ```

2. **Create `.github/workflows/` directory**
   ```bash
   mkdir -p .github/workflows
   ```

3. **Copy workflow files**
   Copy all `.yml` files from this guide into `.github/workflows/`

4. **Commit and push**
   ```bash
   git add .github/
   git commit -m "Add GitHub Actions CI/CD workflows"
   git push origin main
   ```

5. **Check GitHub Actions tab**
   Go to: https://github.com/nightwalker9999/aws-eks-platform-project/actions

---

### Running Workflows

#### Automatic Triggers
Workflows run automatically when you:
- Push code to `main` or `develop`
- Create a pull request
- Modify relevant files (terraform/, k8s/, app/)

#### Manual Trigger
To run the **Local Infrastructure Test** manually:

1. Go to Actions tab: https://github.com/nightwalker9999/aws-eks-platform-project/actions
2. Click "Local Infrastructure Test" in left sidebar
3. Click "Run workflow" button (top right)
4. Select environment (dev)
5. Click green "Run workflow" button

---

## 🔍 Understanding the Local Test Workflow

### What Happens in Each Step:

```
┌─────────────────────────────────────────────────┐
│ 1. Setup Docker Buildx                         │
│    - Prepares Docker for multi-platform builds │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 2. Create Kind Cluster                         │
│    - Spins up local Kubernetes cluster         │
│    - Runs in Docker containers                 │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 3. Start LocalStack                            │
│    - Emulates AWS services locally             │
│    - No real AWS costs                         │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 4. Configure AWS CLI                           │
│    - Points to LocalStack endpoint             │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 5. Terraform Validation                        │
│    - Validates syntax                          │
│    - Shows what would be created              │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 6. Build Docker Image                          │
│    - Builds app from Dockerfile                │
│    - Tags as nginx-app:test                   │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 7. Load Image into Kind                        │
│    - Makes image available in cluster          │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 8. Deploy K8s Manifests                        │
│    - Namespace → ConfigMap → Secret            │
│    - Deployment → Service                      │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 9. Verify Deployment                           │
│    - Check pods are running                    │
│    - Test application endpoint                 │
│    - View logs                                 │
└─────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────┐
│ 10. Cleanup                                     │
│    - Stop LocalStack                           │
│    - Delete Kind cluster                       │
└─────────────────────────────────────────────────┘
```

---

## 📊 Viewing Results

### In GitHub Actions Tab:

**Green checkmark (✅):** All tests passed
**Red X (❌):** Tests failed - click for details

### Workflow Run Details:

Click on any workflow run to see:
- Each step's output
- Error messages (if any)
- Logs from each component
- Duration and resource usage

---

## 🛠️ Troubleshooting

### Common Issues:

**Issue:** Terraform validation fails
**Solution:** Check `terraform fmt` output, run locally first

**Issue:** K8s manifest validation fails
**Solution:** Validate YAML syntax, check API versions

**Issue:** Docker build fails
**Solution:** Check Dockerfile, ensure base image exists

**Issue:** LocalStack timeout
**Solution:** Increase timeout, check Docker resources

**Issue:** Kind cluster creation fails
**Solution:** Check Docker is running, enough resources

---

## 📈 What This Demonstrates

### For Resume / Interviews:

✅ **GitHub Actions expertise**
- Workflow design and triggers
- Job orchestration
- Conditional execution

✅ **Infrastructure as Code**
- Terraform validation
- Automated testing
- LocalStack integration

✅ **Kubernetes proficiency**
- Manifest management
- Deployment automation
- Kind cluster operations

✅ **Docker skills**
- Multi-stage builds
- Container registry usage
- Image optimization

✅ **CI/CD best practices**
- Automated validation
- Environment simulation
- Test-driven infrastructure

---

## 🎯 Next Steps

### Enhancements to Add:

1. **Security scanning**
   - Add Trivy for container scanning
   - Add tfsec for Terraform security

2. **Notifications**
   - Slack notifications on failure
   - Email alerts for critical issues

3. **Deployment**
   - Add production deployment workflow
   - Blue-green deployment strategy

4. **Monitoring**
   - Add workflow performance metrics
   - Track build times and success rates

---

## 📚 Learning Resources

**GitHub Actions:**
- Official Docs: https://docs.github.com/en/actions
- Marketplace: https://github.com/marketplace?type=actions

**LocalStack:**
- Docs: https://docs.localstack.cloud
- AWS Service Coverage: https://docs.localstack.cloud/user-guide/aws/feature-coverage/

**Kind:**
- Quick Start: https://kind.sigs.k8s.io/docs/user/quick-start/
- Configuration: https://kind.sigs.k8s.io/docs/user/configuration/

---

## ✨ Benefits of This Setup

### For Development:
- ✅ Catch errors before deployment
- ✅ Consistent testing environment
- ✅ No AWS costs for testing
- ✅ Fast feedback loop

### For Learning:
- ✅ Real-world CI/CD patterns
- ✅ Infrastructure automation
- ✅ Kubernetes operations
- ✅ DevOps best practices

### For Portfolio:
- ✅ Demonstrates automation skills
- ✅ Shows testing discipline
- ✅ Professional workflow design
- ✅ Production-ready practices

---

## 📝 Interview Talking Points

**"Tell me about your CI/CD experience"**

> "I built a complete CI/CD pipeline using GitHub Actions for an AWS EKS platform project. The pipeline includes automated Terraform validation, Kubernetes manifest testing, Docker image builds, and comprehensive local testing using LocalStack and Kind clusters. This allowed me to test infrastructure changes without incurring AWS costs and catch deployment issues before production."

**"How do you test infrastructure changes?"**

> "I use a combination of static validation and dynamic testing. First, I validate Terraform syntax and run dry-run plans. Then I simulate AWS infrastructure using LocalStack and deploy to a Kind cluster to test the full application stack. This catches configuration issues, missing dependencies, and integration problems early in the development cycle."

**"What's your experience with GitHub Actions?"**

> "I've designed multi-stage workflows with conditional execution, artifact caching, and matrix builds. I understand workflow triggers, job dependencies, and how to integrate with external tools like Terraform, Docker, and Kubernetes. I've also implemented PR commenting for validation feedback and automated cleanup to manage resources."
