output "servers_ipv4" {
  description = "Public IPv4 addresses of created droplets"
  value       = module.openvpn_do_infrastructure_module.servers_ipv4
}
