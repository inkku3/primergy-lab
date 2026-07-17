# terraform/provision_vm.tf
resource "proxmox_virtual_environment_vm" "vm" {
  for_each  = var.vms
  name      = each.key
  node_name = var.proxmox_node_name
  vm_id     = each.value.vmid

  clone {
    vm_id = "9000" # mallipohjan id
    full  = true
  }

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = each.value.disk
    ssd          = true
  }

  network_device {
    bridge = "vmbr0"
  }

  agent {
    enabled = false
  }

  initialization {
    user_account {
      username = "ansible"
      keys     = [var.ssh_public_key]
      password = var.virtual_environment_root_password
    }
    ip_config {
      ipv4 {
        address = "${each.value.ip}"
        gateway = "192.168.0.1"
      }
    }
  }
}
