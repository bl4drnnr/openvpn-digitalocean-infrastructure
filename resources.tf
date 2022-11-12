resource "local_file" "group_vars" {
  content         = <<EOT
---
ansible_ssh_private_key: openvpn_do_ssh.pem
    EOT
  filename        = "${path.module}/ansible/group_vars/${var.group_name}"
}

resource "local_file" "servers_ipv4" {
  content         = join("\n", [
    "[${var.group_name}]",
    join("\n", [
      for idx, s in module.openvpn_do_infrastructure_module.servers_ipv4:
      "${var.droplet_names[idx]} ansible_host=${s} ansible_user=${var.users[idx]}"
    ])
  ]
  )
  filename        = "${path.module}/ansible/inventory.txt"
}

resource "local_file" "ssh_keys" {
  content         = module.openvpn_do_infrastructure_module.ssh_keys
  filename        = "${path.module}/ansible/openvpn_do_ssh.pem"
  file_permission = "0400" 
}

resource "local_file" "ping_servers" {
  content         = <<EOT
---
- name:L Test connection to all servers
  hosts: all
  become: yes

  tasks:
  
  - name: Ping server
    ping:
  EOT
  filename        = "${path.module}/ansible/ping_server.yml"
  file_permission = "0700"
}

resource "local_file" "ansible_playbooks_create_users" {
  count           = length(var.users)
  content         = <<EOT
---
- name: Create non-root user for ${var.users[count.index]}
  hosts: ${module.openvpn_do_infrastructure_module.servers_ipv4[count.index]}
  become: yes

  tasks:
  - name: Create non-root user ${var.users[count.index]} for ${var.droplet_names[count.index]}
    ansible.builtin.user:
      name: ${var.users[count.index]}
      group: sudo
    EOT
  filename        = "${path.module}/ansible/create_users_${var.droplet_names[count.index]}.yml"
  file_permission = "0700"
}


