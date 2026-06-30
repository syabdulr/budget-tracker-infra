terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------
# Resource Group (Terraform State)
# -----------------------------
resource "azurerm_resource_group" "tfstate" {
  name     = "rg-budget-tfstate-dev-eastus"
  location = "East US"

  tags = {
    project     = "budget-tracker"
    environment = "dev"
    managed_by  = "terraform"
  }
}

# -----------------------------
# Storage Account (Terraform State)
# -----------------------------
resource "azurerm_storage_account" "tfstate" {
  name                     = "stbudgettfstatedev01"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  https_traffic_only_enabled = true

  blob_properties {
    versioning_enabled = true
  }

  tags = {
    project     = "budget-tracker"
    environment = "dev"
    managed_by  = "terraform"
  }
}

# -----------------------------
# Blob Container (State Storage)
# -----------------------------
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}