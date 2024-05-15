# OpenShift

## POC objectives

Validate the possible use of OpenShift for deploying and managing a multi-tier architecture in an hybrid cloud context to showcase automated builds, cross-cluster deployments, log aggregation and monitoring, scaling, and failover capabilities.

## Infra architecture

> TODO: Logical components, ports/protocols, cloud type.

### Diagram

![](assets/openshift-infra.svg)

## Scenario

> Describe step-by-step the scenario. Write it using this format (BDD style).

### Summary

The scenario describes the setup of a multi-cloud OpenShift environment. On-premises infrastructure is used to host a RHEL management workstation, a MariaDB database, an EFM stack and an OpenShift cluster, while AWS and Azure are used to provision OpenShift clusters. Each cluster is set up with 3 nodes and a load balancer to route traffic to the nodes.

The [Bookstack](https://www.bookstackapp.com/) multi-tier application consists of a frontend, backend, and database tier. The application images are built using a CI/CD pipeline and stored in a container registry. Argo CD is used for GitOps-based deployments across all clusters. Route 53 is used for DNS-based failover routing. The application is tested for functionality, load, and failover scenarios.

---

### Feature 1: Cluster Setup

#### Task 1: Set Up RHEL Management Workstation on On-Premises Infrastructure
- **Given** the on-premises infrastructure is ready with a hypervisor
- **When** a RHEL management workstation is provisioned
- **Then** the workstation should be configured with necessary tools for managing the OpenShift clusters

#### Task 2: Provision AWS Instances for OpenShift
- **Given** AWS account credentials and appropriate permissions
- **When** EC2 instances for master and worker nodes are provisioned
- **Then** the instances should be ready for OpenShift installation

#### Task 3: Set up Load Balancer for AWS Cluster
- **Given** AWS account credentials and appropriate permissions
- **And** EC2 instances for the OpenShift cluster are provisioned
- **When** an Elastic Load Balancer (ELB) is configured
- **Then** the load balancer should route traffic to the OpenShift master nodes

#### Task 4: Set up OpenShift Cluster on AWS
- **Given** the AWS instances are provisioned
- **And** the load balancer is configured
- **And** the necessary network configuration is in place
- **When** the OpenShift installer is run with the AWS configuration
- **Then** the OpenShift cluster should be successfully deployed on AWS
- **And** the cluster API should be accessible via the load balancer

#### Task 5: Provision Azure Instances for OpenShift
- **Given** Azure account credentials and appropriate permissions
- **When** Azure VMs for master and worker nodes are provisioned
- **Then** the instances should be ready for OpenShift installation

#### Task 6: Set up Load Balancer for Azure Cluster
- **Given** Azure account credentials and appropriate permissions
- **And** VMs for the OpenShift cluster are provisioned
- **When** an Azure Load Balancer is configured
- **Then** the load balancer should route traffic to the OpenShift master nodes

#### Task 7: Set up OpenShift Cluster on Azure
- **Given** the Azure instances are provisioned
- **And** the load balancer is configured
- **And** the necessary network configuration is in place
- **When** the OpenShift installer is run with the Azure configuration
- **Then** the OpenShift cluster should be successfully deployed on Azure
- **And** the cluster API should be accessible via the load balancer

#### Task 8: Provision On-Premises Infrastructure for OpenShift
- **Given** the on-premises infrastructure is ready with a hypervisor
- **When** virtual machines for master and worker nodes are provisioned
- **Then** the instances should be ready for OpenShift installation

#### Task 9: Set up Load Balancer for On-Premises Cluster
- **Given** the on-premises infrastructure is ready
- **And** the virtual machines are provisioned
- **When** a load balancer is configured (e.g., HAProxy, F5)
- **Then** the load balancer should route traffic to the OpenShift master nodes

#### Task 10: Set up OpenShift Cluster On-Premises
- **Given** the on-premises instances are provisioned
- **And** the load balancer is configured
- **And** the necessary network configuration is in place
- **When** the OpenShift installer is run with the on-premises configuration
- **Then** the OpenShift cluster should be successfully deployed on-premises
- **And** the cluster API should be accessible

#### Task 11: Set Up Logging Subsystem Across All Clusters
- **Given** AWS, Azure, and on-premises OpenShift clusters are operational
- **When** a centralized logging solution (Elasticsearch, Fluentd, and Kibana - EFK) is configured
- **Then** logs should be aggregated and accessible from all clusters
- **And** log analysis should be possible across all clusters

---

### Feature 2: Multi-Tier Application Setup

#### Task 1: Set Up MariaDB on On-Premises Server
- **Given** the on-premises infrastructure is ready
- **When** MariaDB is installed and configured on the on-premises server
- **Then** the database should be ready for the multi-tier application

#### Task 2: Prepare Application Images
- **Given** the multi-tier application source code
- **And** Dockerfiles for building the application images
- **When** the images are built using the CI/CD pipeline
- **Then** the images should be stored in a container registry accessible to all clusters

#### Task 3: Set up GitHub Webhook
- **Given** the GitHub repository with the multi-tier application code
- **When** a webhook is configured to trigger builds on OpenShift
- **Then** a push to the repository should trigger a new build

#### Task 4: Create BuildConfig in OpenShift
- **Given** the multi-tier application code in GitHub
- **When** a BuildConfig is created in OpenShift
- **Then** OpenShift should be able to build the Docker image from the repository

#### Task 5: Install Argo CD on Management Workstation
- **Given** the RHEL management workstation is set up
- **When** Argo CD is installed on the workstation
- **Then** the workstation should be able to manage deployments to all OpenShift clusters

#### Task 6: Configure Argo CD to Manage All Clusters
- **Given** Argo CD is installed on the management workstation
- **When** the OpenShift clusters (AWS, Azure, on-premises) are added to Argo CD
- **Then** Argo CD should be able to manage deployments across all clusters

#### Task 7: Deploy Application Tiers to All Clusters Using GitOps
- **Given** the application images are available in the container registry
- **And** Argo CD is configured to manage all OpenShift clusters
- **When** the application deployment is initiated using a GitOps approach with Argo CD
- **Then** the application tiers (frontend, backend, database) should be successfully deployed on all clusters
- **And** the service should be accessible from all clusters

#### Task 8: Configure Route 53 for DNS-Based Failover
- **Given** Route 53 is available in the AWS account
- **When** a hosted zone is created for the application's domain
- **And** health checks are configured for each cluster's load balancer
- **Then** DNS records should be created with failover routing policies to ensure traffic is redirected to healthy clusters

---

### Feature 3: Testing and Validation

#### Task 1: Verify Application Functionality on AWS
- **Given** the multi-tier application is deployed on the AWS cluster
- **When** functional tests are run against the application on AWS
- **Then** all tests should pass

#### Task 2: Verify Application Functionality on Azure
- **Given** the multi-tier application is deployed on the Azure cluster
- **When** functional tests are run against the application on Azure
- **Then** all tests should pass

#### Task 3: Verify Application Functionality On-Premises
- **Given** the multi-tier application is deployed on the on-premises cluster
- **When** functional tests are run against the application on-premises
- **Then** all tests should pass

#### Task 4: Perform Load Testing Across Clusters
- **Given** the multi-tier application is deployed across AWS, Azure, and on-premises clusters
- **When** load tests are run to simulate high traffic
- **Then** the application should perform optimally and handle the load without issues

#### Task 5: Set Up Cross-Cluster Failover
- **Given** the multi-tier application is deployed across AWS, Azure, and on-premises clusters
- **When** a cross-cluster failover mechanism (e.g., Global Server Load Balancer, DNS-based failover) is configured
- **Then** the application should continue to be accessible via other clusters if one cluster fails

#### Task 6: Validate Cross-Cluster Failover
- **Given** the cross-cluster failover mechanism is configured
- **When** one of the clusters goes down
- **Then** the application should continue to be accessible via the other clusters
- **And** the failover should be seamless

#### Task 7: Test Autoscaling
- **Given** autoscaling is configured for all clusters
- **When** load tests are performed to increase CPU/memory usage
- **Then** the application should scale out additional pods on all clusters
- **And** the application should scale in when the load decreases

## Cost

> TODO: analysis of load-related costs.

> TODO: option to reduce or adapt costs (practices, subscription)

## Return of experience

> TODO: take a position on the poc that has been produced.

> TODO: did it validate the announced objectives?
