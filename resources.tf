resource "local_file" "servers_ipv4" {
  content   = join("\n", [
    for idx, s in module.openvpn_do_infrastructure_module.servers_ipv4:
      <<EOT
${var.droplet_names[idx]} ansible_host=${s} ansible_user=root ansible_ssh_private_key=openvpn_do_ssh.pem
      EOT
  ])
  filename  = "${path.module}/ansible/inventory.txt"
}

resource "local_file" "ssh_keys" {
  content   = module.openvpn_do_infrastructure_module.ssh_keys
  filename  = "${path.module}/ansible/openvpn_do_ssh.pem"
}
