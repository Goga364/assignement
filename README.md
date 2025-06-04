# EKS + Karpenter Infrastructure on AWS

This repository contains Terraform and Terragrunt code to deploy a production-ready Amazon EKS cluster using the latest Kubernetes version. It includes [Karpenter](https://karpenter.sh) as the autoscaler with support for both **x86 (amd64)** and **Graviton (arm64)** Spot Instances.

---

## Features

- EKS cluster with public API endpoint
- Dedicated VPC with private/intra subnets
- Karpenter installed via Helm
- Two NodeClasses + NodePools:
  - `x86-pool` – AMD64 Spot instances
  - `arm64-pool` – Graviton Spot instances
- Minimal EKS managed node group for control plane support
- Sample workload deployment (`inflate` pod) for testing

---

## How to Use

### 1. Prerequisites

- AWS CLI
- Terraform >= 1.6
- Terragrunt >= 0.50
- kubectl installed
- Helm installed

### 2. Clone and Deploy the Infrastructure

```bash
git clone https://github.com/Goga364/assignement.git
cd assignement/live/dev/vpc
terragrunt init && terragrunt apply -auto-approve

cd ../eks
terragrunt init && terragrunt apply -auto-approve

cd ../karpenter
terragrunt init && terragrunt apply -auto-approve

```


> Deploying all resources takes ~20–25 minutes.
> `terragrunt run-all` is **not recommended** on first apply due to dependency outputs — follow the ordered steps above instead.


---

## Verifying the Setup

After deployment, you can verify Karpenter provisioning by scaling the example pod:

```bash
kubectl scale deployment inflate --replicas=5
```

Then run:

```bash
kubectl get nodes -o wide
```

You’ll see one of the pools spin up a new node based on your pod architecture (amd64 or arm64).

---

## Notes

- NodePools use Spot instances for cost efficiency.
- Graviton-based arm64 nodes are supported via AL2023 AMI.
- Terragrunt handles dependency order (VPC → EKS → Karpenter).

---

## Structure

```
live/
└── dev/
    ├── vpc/
    ├── eks/
    └── karpenter/
```

---

## Author

Goga Samunashvili  
DevOps Engineer

---

## Disclaimer

This is a proof-of-concept setup and should be audited before production use.


# Innovate Inc. – AWS Cloud Infrastructure Architecture

This document outlines the cloud infrastructure design for Innovate Inc.'s web application, deployed on AWS using managed Kubernetes and aligned with best practices for security, scalability, and cost-efficiency.

---

## 1. Cloud Environment Structure

We recommend **three AWS accounts** under AWS Organizations for clear separation and cost tracking:
- **Development** – sandboxed for testing and internal experimentation
- **Staging** – mirrors production for validation before release
- **Production** – hosts the live application, with restricted access

---

## 2. Network Design

### VPC Design
Each environment has its own **VPC** with the following structure:
- **Public Subnets** – Host ALB and NAT Gateways
- **Private Subnets** – Host EKS worker nodes
- **Database Subnets** – Host RDS PostgreSQL (private, no internet access)

### Security Measures
- **Internet Gateway (IGW)** attached to public subnets for ALB/NAT access
- **NAT Gateway** in each public subnet for private subnet egress
- **VPC Security Groups**: Strict ingress/egress for ALB, EKS, RDS
- **AWS Secrets Manager**: Centralized secure storage of sensitive data
- **WAF** (optional) for ALB/CloudFront protection

---

## 3. Compute Platform – Amazon EKS

### Kubernetes Management
- **Amazon EKS** manages cluster control plane
- **Flask REST API** runs as a Kubernetes deployment
- **Separate node groups** (e.g., backend vs. ArgoCD workloads)
- **Ingress Controller** exposes APIs securely via ALB

### Scaling and Allocation
- **Cluster Autoscaler** or **Karpenter** for dynamic scaling
- Pod-level resource requests/limits and **HPA**

### CI/CD Strategy
- **GitHub Actions**: Code build, test, and push Docker images to **ECR**
- **ArgoCD**: GitOps deployment model pulling manifests from GitHub to EKS

---

## 4. Frontend Hosting – SPA (React)

- Static React frontend is deployed to **S3**
- Delivered via **CloudFront CDN** for performance and edge caching
- DNS managed by **Route 53**

---

## 5. Database – PostgreSQL

### Service
- **Amazon RDS for PostgreSQL** in database subnets

### High Availability & Backup
- **Multi-AZ deployment** enabled
- Daily automated backups + PITR
- Optional **AWS Backup** integration for cross-region snapshots

---

## 6. High-Level Architecture Diagram

![Innovate Inc AWS Architecture](infrastructure.png)

---

This solution ensures Innovate Inc. is prepared for scale, maintains security for sensitive user data, and aligns with modern DevOps practices.
