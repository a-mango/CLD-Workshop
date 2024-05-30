variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://proxmox.example.com:8006/api2/json"
}

variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node"
  type        = string
  default     = "pve0"
}

variable "proxmox_storage" {
  description = "Proxmox storage name"
  type        = string
  default     = "local-lvm"
}

variable "proxmox_pool" {
  description = "Proxmox pool name"
  type        = string
  default     = "workshop"
}

variable "proxmox_container_template" {
  description = "Template for the LXC containers"
  type        = string
  default     = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
}

variable "proxmox_container_memory" {
  description = "Memory for the LXC containers"
  type        = number
  default     = 512
}

variable "proxmox_container_cpu" {
  description = "CPU cores for the LXC containers"
  type        = number
  default     = 1
}

variable "template_id" {
  description = "Proxmox template ID"
  type        = string
  default = "rhel9-cloudinit"
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

variable "ssh_password" {
variable "ssh_password" {
  description = "VM password"
  type        = string
  sensitive   = true
}

# variable "vm_sockets" {
#   description = "Number of sockets for VMs"
#   type        = number
#   default     = 1
# }
# variable "vm_sockets" {
#   description = "Number of sockets for VMs"
#   type        = number
#   default     = 1
# }

# variable "vm_vcpus" {
#   description = "Number of vCPUs for VMs"
#   type        = number
#   default     = 4
# }

variable "vm_cpu_type" {
  description = "CPU type for VMs"
  type        = string
  default     = "host"
# variable "vm_vcpus" {
#   description = "Number of vCPUs for VMs"
#   type        = number
#   default     = 4
# }

variable "vm_cpu_type" {
  description = "CPU type for VMs"
  type        = string
  default     = "host"
}

variable "vm_sockets" {
  description = "Number of sockets for VMs"
  type        = number
  default     = 1
}

variable "vm_disk_size" {
  description = "Disk size for VMs"
  type        = string
  default     = "50G"
}

variable "vm_network_bridge" {
  description = "Network bridge"
  type        = string
  default     = "vnet10"
  default     = "vnet10"
}

variable "vm_network_gateway" {
  description = "vm_network_gateway IP"
variable "vm_network_gateway" {
  description = "vm_network_gateway IP"
  type        = string
  default     = "10.0.10.1"
}


variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 3
}

variable "master_id_base" {
  description = "Base ID for master nodes"
  type        = number
  default     = 8000
}

variable "master_memory" {
  description = "Memory for master nodes in MB"
  type        = number
  default     = 16384
}

variable "master_cores" {
  description = "Number of cores for master nodes"
  type        = number
  default     = 4
}

variable "master_ips" {
  description = "IP addresses for master nodes"
  type        = list(string)
  default     = ["10.0.10.10", "10.0.10.11", "10.0.10.12"]
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 3
}

variable "worker_id_base" {
  description = "Base ID for worker nodes"
  type        = number
  default     = 8010
}

variable "worker_memory" {
  description = "Memory for VMs in MB"
  type        = number
  default     = 8192
}

variable "worker_cores" {
  description = "Number of cores for VMs"
  type        = number
  default     = 2
}

variable "worker_ips" {
  description = "IP addresses for master nodes"
  type        = list(string)
  default     = ["10.0.10.15", "10.0.10.16", "10.0.10.17"]
}

# DNS settings
variable "dns_container_name" {
  description = "Name of the DNS container"
  type        = string
  default     = "dns1"
}

variable "dns_container_password" {
  description = "Password for the DNS container"
  type        = string
  sensitive   = true
}

variable "dns_container_id" {
  description = "ID of the DNS container"
  type        = number
  default     = 8020
}

variable "dns_container_ip" {
  description = "IP address for the DNS container"
  type        = string
  default     = "10.0.10.2"
}

variable "lb_container_name" {
  description = "Name of the load balancer container"
  type        = string
  default     = "lb1"
}

variable "lb_container_password" {
  description = "Password for the load balancer container"
  type        = string
  sensitive   = true
}

variable "lb_container_id" {
  description = "ID of the load balancer container"
  type        = number
  default     = 8021
}

variable "lb_container_ip" {
  description = "IP address for the load balancer container"
  type        = string
  default     = "10.0.10.3"
}
