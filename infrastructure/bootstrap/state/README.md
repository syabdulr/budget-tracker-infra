# State Management

This folder defines how Terraform state is structured.

We use:
- Azure Storage Account backend
- Separate state keys per environment:
  - dev.terraform.tfstate
  - prod.terraform.tfstate