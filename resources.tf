resource "local_file" "servers_ipv4" {
  content     = join("\n", [
    for s in module.openvpn_do_infrastructure_module.servers_ipv4:
     format("%q", s)
  ])
  filename    = "${path.module}/ansible/inventory.txt"
}