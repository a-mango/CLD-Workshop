resource "proxmox_vm_qemu" "master" {
  count       = var.master_count
  vmid        = var.master_id_base + count.index
  name        = "rhel9-master-${count.index + 1}"
  target_node = var.proxmox_node
  pool        = var.proxmox_pool

  clone = var.template_id

  os_type = "cloud-init"
  qemu_os = "l26"
  cores   = var.vm_cores
  sockets = var.vm_sockets
  vcpus   = var.vm_vcpus
  memory  = var.vm_memory
  cpu     = "host"
  scsihw  = "virtio-scsi-single"

  boot     = "c"
  bootdisk = "order=scsi0"

  agent = 1

  ssh_user  = var.ssh_user
  sshkeys   = var.ssh_public_key
  ipconfig0 = "ip=dhcp"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = var.proxmox_storage
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage  = var.proxmox_storage
          size     = var.vm_disk_size
          iothread = true
          discard  = true
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = var.vm_network_bridge
  }
}
