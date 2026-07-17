# terraform/ansible_inventory.tf
resource "local_file" "ansible_inventory" {
  filename             = "${path.module}/../ansible/inventory.ini"
  file_permission      = "0644"
  directory_permission = "0755"
  content = templatefile("${path.module}/inventory.tftpl", {
    control_plane_ip = split("/", var.vms["control-plane"].ip)[0]
    worker_ips       = [split("/", var.vms["worker-1"].ip)[0], split("/", var.vms["worker-2"].ip)[0]]
    utility_ip       = split("/", var.vms["utility"].ip)[0]
    cloudflared_ip   = split("/", var.vms["cloudflared"].ip)[0]
  })
}
