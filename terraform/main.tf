resource "proxmox_vm_qemu" "master" {
  count       = var.master_count
  name        = "openshift-master-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.template_id
  full_clone = true
  os_type     = "cloud-init"
  cores       = var.vm_cores
  memory      = var.vm_memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  ipconfig0   = "ip=dhcp"
  ssh_user    = var.ssh_user
  pool        = var.proxmox_pool
  network {
    model  = "virtio"
    bridge = var.network_bridge
  }
  disk {
    size         = var.vm_disk_size
    type         = "scsi"
    storage      = var.proxmox_storage
    # storage_type = "lvm"
  }
  cicustom = <<EOF
  #cloud-config
  hostname: openshift-master-${count.index + 1}
  manage_etc_hosts: true
  users:
    - name: ${var.ssh_user}
      ssh_authorized_keys:
        - ${var.ssh_public_key}
      sudo: ['ALL=(ALL) NOPASSWD:ALL']
      groups: sudo
      shell: /bin/bash
  chpasswd:
    list: |
      ${var.ssh_user}:${var.vm_password}
    expire: False
  ssh_pwauth: true
  EOF
}

resource "proxmox_vm_qemu" "worker" {
  count       = var.worker_count
  name        = "openshift-worker-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.template_id
  os_type     = "cloud-init"
  cores       = var.vm_cores
  memory      = var.vm_memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  ipconfig0   = "ip=dhcp"
  ssh_user    = var.ssh_user
  pool        = var.proxmox_pool
  network {
    model  = "virtio"
    bridge = var.network_bridge
  }
  disk {
    size         = var.vm_disk_size
    type         = "scsi"
    storage      = var.proxmox_storage
    # storage_type = "lvm"
  }
  cicustom = <<EOF
  #cloud-config
  hostname: openshift-master-${count.index + 1}
  manage_etc_hosts: true
  users:
    - name: ${var.ssh_user}
      ssh_authorized_keys:
        - ${var.ssh_public_key}
      sudo: ['ALL=(ALL) NOPASSWD:ALL']
      groups: sudo
      shell: /bin/bash
  chpasswd:
    list: |
      ${var.ssh_user}:${var.vm_password}
    expire: False
  ssh_pwauth: true
  EOF
}
