terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "openvpn_instance_1_ssh" {
  name = "openvpn-instance-1-ssh"
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-20-04-x64"
  name   = "openvpn-instance-1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.openvpn_instance_1_ssh.id]
}

output "server_id" {
  value       = digitalocean_droplet.web.ipv4_address
}

