// Padding: original snippet starts at line 150
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
resource "digitalocean_droplet" "web_server" {
  image    = "ubuntu-22-04-x64"
  name     = "prod-web-01"
  region   = "sfo3"
  size     = "s-2vcpu-4gb"
  ssh_keys = [data.digitalocean_ssh_key.main.id]

  provisioner "remote-exec" {
    inline = [
      "export DATADOG_API_KEY=dd-api-a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6",
      "bash -c \"$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)\""
    ]
  }
}

// Sensitive variables for provider configuration. These should be in a separate tfvars file.

variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  default     = "dop_v1_8d3e6f2a7b1c4d9f8a6e3b0c5d7f0a9b8c7d6e5f4a3b2c1d0e9f8a7b6c5d4e3f"
}

resource "digitalocean_database_cluster" "postgres_prod" {
  name       = "prod-db-cluster"
  engine     = "pg"
  version    = "14"
  size       = "db-s-2vcpu-4gb"
  region     = "sfo3"
  node_count = 1
}

resource "digitalocean_database_user" "app_user" {
  cluster_id = digitalocean_database_cluster.postgres_prod.id
  name       = "app_user"
  mysql_auth_plugin = "caching_sha2_password"
  password   = "DbP@ssw0rdF0rProd!2024*"
}
