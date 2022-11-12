resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "digitalocean_ssh_key" "openvpn_do_ssh" {
  name       = "OpenVPN-DO-SSH"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "digitalocean_project" "open_vpn" {
  name        = "OpenVPN"
  description = "OpenVPN DigitalOcean-based infrastructure"
  purpose     = "Custom OpenVPN server"
}

resource "digitalocean_droplet" "droplet_instance" {
  image  = "ubuntu-20-04-x64"
  count  = length(var.droplet_names)
  name   = var.droplet_names[count.index]
  size   = var.droplet_size
  region = var.region
  ssh_keys = [digitalocean_ssh_key.openvpn_do_ssh.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "digitalocean_project_resources" "open_vpn_resources" {
  project   = digitalocean_project.open_vpn.id
  resources = digitalocean_droplet.droplet_instance[*].urn
}
