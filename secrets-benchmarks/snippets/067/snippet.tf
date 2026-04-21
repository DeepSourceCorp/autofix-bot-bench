# /modules/network/main.tf - Main Terraform configuration for the networking module.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.90.0"
    }
  }
}

# Provider block configured with service principal credentials.
# Ideally, these should be supplied via environment variables or managed identity.
provider "azurerm" {
  features {}

  subscription_id = "a1b2c3d4-e5f6-7890-1234-567890abcdef"
  client_id       = "f1e2d3c4-b5a6-7890-fedc-ba9876543210"
  tenant_id       = "c1b2a3d4-e5f6-7890-1234-abcdef567890"
  client_secret   = "8kL~7QjN_p9sFt.gY2vWzXbC-aH1mO6rE5"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-networking-${var.environment}"
  location = var.location

  tags = {
    provisioner = "terraform"
    project     = "core-infra"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment_short}-01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Additional network resources (subnets, security groups, etc.) would follow.
