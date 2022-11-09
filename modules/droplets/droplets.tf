data "digitalocean_ssh_key" "do_ssh_key" {
  name = "openvpn-instance-1-ssh"
}

# resource "digitalocean_project" "open_vpn" {
#   name        = "OpenVPN"
#   description = "OpenVPN DigitalOcean-based infrastructure"
#   purpose     = "Custom OpenVPN server"
# }

resource "digitalocean_droplet" "droplet_instance" {
  image  = "ubuntu-20-04-x64"
  count  = length(var.droplet_names)
  name   = var.droplet_names[count.index]
  size   = var.droplet_size
  region = var.region
  ssh_keys = [data.digitalocean_ssh_key.do_ssh_key.id]

  lifecycle {
    create_before_destroy = true
  }
}

# resource "digitalocean_project_resources" "open_vpn_resources" {
#   project   = digitalocean_project.open_vpn.id
#   resources = digitalocean_droplet.droplet_instance[*].urn
# }
