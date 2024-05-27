proxmox_api_url = "https://192.168.12.20:8006/api2/json"
proxmox_user = "workshop@pve"
proxmox_pool = "workshop"
proxmox_node = "pve0"
template_id = "rhel9-cloudinit"
ssh_user = "cloud-user"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsLaVoMFRHvHhkbGPb7Vm6svF29rYLWXU3GYMhU5ssuvl3J+2ixoNXzLrIl6Mn0blYVKKU4byBgVbpPCjws6eEui1xrhc0nK3axXIZIzYMSibUZlXCgJGb/cnPz2HklHQGKo+V63P2UMvp5jddsnYJB+1N/iH3Y00irCJnTyk5nfR/EaOF7j0dsQIbAtZ2tbj9mqkBsGN3+t0ySQ2MTwI7PmZ0KYVCto07zAUQg3fGcoTv0lJlU0BZlWilbUsTQ11FEwaaCJkh1pYA1L1c7JMiqNd2zC0Fzy3ZWqhevXsqkLSyQV+LgMRZv4+C3u7q+BwR6ikOnbx9SYwjGF38QiSoC0QcUQ5ZoCzi08Srxzzkxg2lnT78yISyDWzyu1t68LeELNVWbTmDwtdKgCzGK3n5xFJb6OgpLsr2Jq3f70LN1OzUopW1t8S1WaonrlsjFf0GJiZJzlU8yGLaPcaFnAD/d6foe03r0TGmYDxFwh9RqC0cC7ngDR6XeBXig13d7g5fIqEOlMx3XJk7gyFHbBPekIaMJKeuzOiRfeLCQanbqPJc9EiC7HK41T/HE/zBtKNQLED1AAduzlOlJOBM/F6IN/MmASFuKrdDou0oPPU98wuRIyPypfoxrMF0B3m7UnDMKESe5SR0FZUH24dY5G+Eooni4VuDc0n2p/DBbyNekQ=="
vm_cores = 2
vm_memory = 8192
vm_disk_size = "50G"
vm_password = "workshop"
vm_network_bridge = "vnet10"
master_count = 1
master_id_base = 8000
worker_count = 1
worker_id_base = 8010