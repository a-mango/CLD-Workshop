output "dns_server_ip" {
  value = proxmox_lxc.dns_server.network[0].ip
  description = "The IP address of the DNS server"
}

output "lb_ip" {
  value = proxmox_lxc.load-balancer.network[0].ip
  description = "The IP address of the load balancer"
}

output "master_ips" {
  value = [for i in var.master_ips: i]
  description = "The IP addresses of the master nodes"
}

output "worker_ips" {
  value = [for i in var.worker_ips: i]
  description = "The IP addresses of the worker nodes"
}