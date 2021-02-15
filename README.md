# kon-infrastructure

The showcase of organization infrastructure on Google Cloud using Terraform

**Features**:

- Terraform modules for common Google Cloud components(Project, GKE, CloudDNS, and so on)
- Terraform module for environment
- Environment changes via promotion environment module through development => stage => production
- Bootstrap module to setup Terraform and organization level IAM, groups, and policy
- Terraform Cloud for storing state and plan to apply (one place)
- Shared VPC network(one place for managing firewall, subnets, and so on)
- User IAM via Google Groups
- GKE IAM via Workload Identity
- Separate GCP project for every component
- Shared GCP projects for container image registry, helm chart registry, DNS
