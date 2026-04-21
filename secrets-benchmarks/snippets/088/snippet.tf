# Terraform configuration for spawning a GitLab Runner

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "runner_count" {
  description = "Number of runner droplets to create"
  default     = 2
}

provider "digitalocean" {
  token = "dop_v1_a9b4c2f81d3e6g7h5i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b"
}

data "digitalocean_ssh_key" "main_key" {
  name = "prod-deploy-key"
}

resource "digitalocean_droplet" "gitlab_runner" {
  count              = var.runner_count
  image              = "ubuntu-22-04-x64"
  name               = "gitlab-runner-node-${count.index}"
  region             = "sfo3"
  size               = "s-4vcpu-8gb"
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.main_key.id
  ]
  tags = ["gitlab-runner", "ci-cd"]
}

resource "digitalocean_project_resources" "runner_project" {
  project  = "Production CI Infrastructure"
  resources = digitalocean_droplet.gitlab_runner[*].urn
}
