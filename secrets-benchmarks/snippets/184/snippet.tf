terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "statestorageacc"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "f1g2h3i4-j5k6-7l8m-9n0o-p1q2r3s4t5u6"
  tenant_id       = "k1j2h3g4-f5e6-d7c8-b9a0-1z2y3x4w5v6u"
  client_id       = "a8b12c34-d56e-78f9-g012-h345i67j89k0"
  client_secret   = "aZ8~9_xYpQ-rS7tV.wJ6fGhK1jL3mN5oB4c2"
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-production-api-services"
  location = "East US"

  tags = {
    environment = "Production"
    owner       = "DevOps"
  }
}
