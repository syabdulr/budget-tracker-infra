# Terraform Bootstrap

This module is responsible for provisioning the Terraform backend infrastructure in Azure.

## Purpose
Terraform requires remote state storage for collaboration and state locking.

This bootstrap layer creates:
- Resource Group for Terraform state
- Storage Account for state files
- Blob container for state locking

## Design Principles
- Single subscription
- Environment separation via state keys (dev/prod)
- No hardcoded secrets
- Fully reproducible infrastructure