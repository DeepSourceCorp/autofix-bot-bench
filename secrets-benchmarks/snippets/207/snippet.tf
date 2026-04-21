# Terraform configuration for Azure core infrastructure

terraform {
  required_version = ">= 1.2.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Provider block configured for a specific service principal
# This should be moved to a secure variables file or vault.
provider "azurerm" {
  features {}

  subscription_id = "8e3d1b9e-315b-4b69-80b1-9f7fd8d9f1e3"
  client_id       = "a2b3c4d5-6e7f-8a9b-0c1d-2e3f4a5b6c7d"
  client_secret   = "aL9~_fH8qY7.s-D3.wX2vR-zM4pE1bN9jK"
  tenant_id       = "f5g6h7i8-9j0k-1l2m-3n4o-5p6q7r8s9t0u"
}

# Define a resource group for shared services
resource "azurerm_resource_group" "shared_services_rg" {
  name     = "rg-shared-services-prod"
  location = "East US 2"

  tags = {
    environment = "production"
    owner       = "infra-team"
  }
}

resource "azurerm_storage_account" "diag_storage" {
  name                     = "diagstoreprodeus2001"
  resource_group_name      = azurerm_resource_group.shared_services_rg.name
  location                 = azurerm_resource_group.shared_services_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
