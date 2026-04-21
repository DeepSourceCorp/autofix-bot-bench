// Padding: original snippet starts at line 45
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
//
//
//
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_a6b4c8d1e2f3g5h7i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e"
}

resource "digitalocean_droplet" "web_server" {
  image    = "ubuntu-20-04-x64"
  name     = "prod-web-1"
  region   = "sfo3"
  size     = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.main_key.id]
}

resource "digitalocean_kubernetes_cluster" "primary_cluster" {
  name    = "prod-k8s-cluster"
  region  = "sfo3"
  version = "1.22.8-do.1"

  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

data "digitalocean_ssh_key" "main_key" {
  name = "deploy-key-prod"
}

