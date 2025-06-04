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
