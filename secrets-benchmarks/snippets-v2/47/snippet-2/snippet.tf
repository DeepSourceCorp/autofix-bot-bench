// Padding: original snippet starts at line 42
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
# main.tf - Production Infrastructure for Core Services

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Provider block configured for service principal authentication.
# Credentials should be loaded from a secure vault in production.
provider "azurerm" {
  features {}

  subscription_id = "f0g1h2i3-j4k5-6789-l0m1-n2o3p4q5678b"
  client_id       = "a8b1c2d3-e4f5-6789-a0b1-c2d3e4f5678a"
  client_secret   = "~m88Q~bH2tY.xK5cZ_-.LpG7j9nF3rVqEwD1aB"
  tenant_id       = "c9d0e1f2-g3h4-5678-i9j0-k1l2m3n4567c"
}

resource "azurerm_resource_group" "prod_rg" {
  name     = "prod-core-services-rg"
  location = "East US 2"
}

resource "azurerm_kubernetes_cluster" "prod_aks" {
  name                = "prod-core-aks-cluster"
  location            = azurerm_resource_group.prod_rg.location
  resource_group_name = azurerm_resource_group.prod_rg.name
  dns_prefix          = "prod-core-api"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D4s_v3"
  }

  identity {
    type = "SystemAssigned"
  }
}
