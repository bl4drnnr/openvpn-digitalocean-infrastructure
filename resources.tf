resource "local_file" "group_vars" {
  content         = join("\n", [
    <<EOT
---
ansible_ssh_private_key: openvpn_do_ssh.pem
    EOT
  ])
  filename        = "${path.module}/ansible/group_vars/${var.group_name}"
}

resource "local_file" "servers_ipv4" {
  content         = join("\n", [
    "[${var.group_name}]",
    join("\n", [
      for idx, s in module.openvpn_do_infrastructure_module.servers_ipv4:
      "${var.droplet_names[idx]} ansible_host=${s} ansible_user=root"
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

resource "local_file" "ansible_playbooks_create_users" {
  content         = join("\n", [
    "---\n- name: Create non-root users for each droplet\n  hosts: all\n  become: yes\n\n  tasks:",
    join("\n", [
      for idx, usr in var.users:
        <<EOT
  - name: Create non-root ${usr} user for ${var.droplet_names[idx]}
    ansible.builtin.user:
      name: ${usr}
      group: sudo
        EOT
    ])
  ])
  filename        = "${path.module}/ansible/create_users.yml"
  file_permission = "0700"
}

resource "local_file" "ping_servers" {
  content         = <<EOT
---
- name: Test connection to all servers
  hosts: all
  become: yes

  tasks:
  
  - name: Ping server
    ping:
  EOT
  filename        = "${path.module}/ansible/ping_server.yml"
  file_permission = "0700"
}

