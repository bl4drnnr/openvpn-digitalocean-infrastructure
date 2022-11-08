output "servers_ipv4" {
  description = "Public IPv4 addresses of created droplets"
  value       = digitalocean_droplet.droplet_instance.*.ipv4_address
}