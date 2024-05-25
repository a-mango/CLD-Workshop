variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://proxmox.example.com:8006/api2/json"
}

variable "proxmox_user" {
  description = "Proxmox user"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node"
  type        = string
}

variable "proxmox_storage" {
  description = "Proxmox storage name"
  type        = string
  default     = "local-lvm"
}

variable "proxmox_pool" {
  description = "Proxmox pool name"
  type        = string
  default     = "default"
}

variable "template_id" {
  description = "Proxmox template ID"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "ssh_user" {
  description = "SSH user"
  type        = string
  default     = "cloud-user"
}

variable "vm_password" {
  description = "VM password"
  type        = string
  sensitive   = true
}

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "master_id_base" {
  description = "Base ID for master nodes"
  type        = number
  default     = 1
}

variable "worker_id_base" {
  description = "Base ID for worker nodes"
  type        = number
  default     = 1
}

variable "vm_memory" {
  description = "Memory for VMs in MB"
  type        = number
  default     = 16384
}

variable "vm_cores" {
  description = "Number of cores for VMs"
  type        = number
  default     = 4
}

variable "vm_disk_size" {
  description = "Disk size for VMs"
  type        = string
  default     = "50G"
}

variable "network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "ip_base" {
  description = "Base IP for VMs"
  type        = string
  default     = "10.0.10"
}
