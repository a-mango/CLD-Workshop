#!/bin/bash

set -e

# Generate an RHEL 9.4 image on the Red Hat console
# https://console.redhat.com/insights/image-builder/imagewizard?source=RHD#SIDs

# Configuration
VM_ID=9000
VM_NAME="rhel9-cloudinit"
VM_POOL="workshop"
STORAGE_NAME="local-lvm"
IMAGE_NAME="rhel-9.4-x86_64-kvm.qcow2"
IMAGE_PATH="/tmp/$IMAGE_NAME"
REMOTE_PATH="/tmp/$IMAGE_NAME"
SSH_HOST="pve0"

echo "Creating $IMAGE_NAME template VM on Proxmox server..."

# Upload the image to the Proxmox server using SCP
# scp $IMAGE_NAME $SSH_HOST:$REMOTE_PATH

# SSH into Proxmox server and execute commands
ssh $SSH_HOST << EOF
set -e
qm create $VM_ID --name $VM_NAME --pool $VM_POOL --memory 4096 --net0 virtio,bridge=vnet10 --cpu host --ostype l26 --sockets 1 --cores 2
qm importdisk $VM_ID $REMOTE_PATH $STORAGE_NAME
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE_NAME:vm-$VM_ID-disk-0
qm set $VM_ID --ide2 $STORAGE_NAME:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID -agent enabled=1
qm template $VM_ID

echo "Template VM $VM_NAME with ID $VM_ID created successfully."
EOF

echo "Process completed."
