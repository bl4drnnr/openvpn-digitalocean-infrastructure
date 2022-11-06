terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
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
