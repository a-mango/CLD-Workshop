# PVE Openshift Cluster
# This module creates a PVE Openshift cluster with a given number of master and worker nodes

# Master nodes
resource "proxmox_vm_qemu" "pve-master-nodes" {
  count       = var.master_count
  vmid        = var.master_id_base + count.index
  name        = "master-${count.index + 1}"
  target_node = var.proxmox_node
  pool        = var.proxmox_pool

  clone = var.template_id

  os_type = "cloud-init"
  qemu_os = "l26"
  memory  = var.master_memory
  cores   = var.master_cores
  sockets = var.vm_sockets
  cpu     = var.vm_cpu_type
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

# Worker nodes
resource "proxmox_vm_qemu" "pve-worker-nodes" {
  count       = var.worker_count
  vmid        = var.worker_id_base + count.index
  name        = "worker-${count.index + 1}"
  target_node = var.proxmox_node
  pool        = var.proxmox_pool

  clone = var.template_id

  os_type = "cloud-init"
  qemu_os = "l26"
  memory  = var.worker_memory
  cores   = var.worker_cores
  sockets = var.vm_sockets
  cpu     = var.vm_cpu_type
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
