// Padding: original snippet starts at line 112
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
# Terraform configuration for provisioning a web server and a database

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = "dop_v1_8a3f5b210c4e7d9f6a2b01c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3"
}

resource "digitalocean_droplet" "web_app" {
  image    = "ubuntu-20-04-x64"
  name     = "web-prod-1"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.main.id]
}

data "digitalocean_ssh_key" "main" {
  name = "prod-deploy-key"
}

resource "digitalocean_database_cluster" "postgres_db" {
  name       = "prod-db-cluster"
  engine     = "pg"
  version    = "13"
  size       = "db-s-2vcpu-4gb"
  region     = "nyc3"
  node_count = 1
}
