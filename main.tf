terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "fra1"
}

variable "droplet_count" {
  type    = number
  default = 1
}

variable "droplet_size" {
  type    = string
  default = "s-1vcpu-1gb"
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "openvpn_instance_1_ssh" {
  name = "openvpn-instance-1-ssh"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "openvpn-instance-${count.index + 1}"
  size   = var.droplet_size
  count  = var.droplet_count
  region = var.region
  ssh_keys = [data.digitalocean_ssh_key.openvpn_instance_1_ssh.id]

  lifecycle {
    create_before_destroy = true
  }
}

output "server_id" {
  value       = digitalocean_droplet.web.*.ipv4_address
}

