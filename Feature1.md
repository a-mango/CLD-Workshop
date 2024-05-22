# Feature 1: Cluster Setup

## Task 1: Set Up RHEL Management Workstation on On-Premises Infrastructure
- https://docs.openshift.com/container-platform/4.11/installing/installing_bare_metal/preparing-to-install-on-bare-metal.html
- https://docs.openshift.com/container-platform/4.11/installing/installing_on_prem_assisted/installing-on-prem-assisted.html

## Task 2: Provision AWS Instances for OpenShift
- https://docs.openshift.com/container-platform/4.11/installing/installing_aws/preparing-to-install-on-aws.html

## Task 3: Set up Load Balancer for AWS Cluster

Retrieve the instance ID of the Openshift master nodes
```sh
aws ec2 describe-instances --filters "Name=tag:Name,Values=<OpenShift-Instance-Tag>"
```

Create a security group
```bash
aws ec2 create-security-group \
    --group-name SG-OpenShift-ELB \
    --description "Security group for OpenShift ELB" \
    --vpc-id <VPC-Id>
```

```bash
aws ec2 authorize-security-group-ingress \
    --group-id <SG-Id> \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress \
    --group-id <SG-Id> \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0
```

Create an application load balancer
```bash
aws elbv2 create-load-balancer \
    --name OS-ALB \
    --subnets <subnet-1-id> <subnet-2-id> \
    --security-groups <OpenShift-ELB-SG-GroupId> \
    --scheme internet-facing \
    --type application
```

Create target group
```bash
aws elbv2 create-target-group \
    --name OS-Master-TG \
    --protocol HTTPS \
    --port 6443 \
    --vpc-id <vpc-id> \
    --health-check-protocol HTTPS \
    --health-check-port 6443 \
    --target-type instance
```

Register target group
```bash
aws elbv2 register-targets \
    --target-group-arn <TG-Arn> \
    --targets Id=<instance-id-1> Id=<instance-id-2> Id=<instance-id-3>
```

## Task 4: Set up OpenShift Cluster on AWS
- https://docs.openshift.com/container-platform/4.11/cli_reference/openshift_cli/getting-started-cli.html

```sh
mkdir ~/openshift-install
cd ~/openshift-install
openshift-install create install-config
```

```yaml
# install-config.yaml
apiVersion: v1
baseDomain: example.com
metadata:
  name: my-cluster
platform:
  aws:
    region: us-east-1
    userTags:
      adminContact: "admin@example.com"
pullSecret: '{"auths": ... }'
sshKey: |
  ssh-rsa AAAA...your-ssh-key
```

```sh
openshift-install create cluster --dir=~/openshift-install
```

## Task 5: Provision On-Premises Infrastructure for OpenShift


## Task 6: Set up Load Balancer for On-Premises Cluster

Install HAProxy
```sh
sudo apt update
sudo apt install -y haproxy
```

```sh
sudo nano /etc/haproxy/haproxy.cfg
```

```sh
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http

frontend openshift-api
    bind *:6443
    default_backend openshift-api

frontend openshift-console
    bind *:443
    default_backend openshift-console

backend openshift-api
    balance roundrobin
    option tcp-check
    server master-1 master1-ip:6443 check
    server master-2 master2-ip:6443 check
    server master-3 master3-ip:6443 check

backend openshift-console
    balance roundrobin
    option httpchk GET /healthz
    http-check expect status 200
    server master-1 master1-ip:443 check
    server master-2 master2-ip:443 check
    server master-3 master3-ip:443 check

```

```sh
sudo systemctl start haproxy
sudo systemctl enable haproxy
```

## Task 7: Set up OpenShift Cluster On-Premises
- **Given** the on-premises instances are provisioned
- **And** the load balancer is configured
- **And** the necessary network configuration is in place
- **When** the OpenShift installer is run with the on-premises configuration
- **Then** the OpenShift cluster should be successfully deployed on-premises
- **And** the cluster API should be accessible