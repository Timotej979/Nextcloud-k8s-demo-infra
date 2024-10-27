<h1 align="center">Nextcloud-k8s-demo-infra</h1>


<div align="center">
  <img src="./docs/assets/hetzner.png" style="height: 100px; width: auto;">
  <img src="./docs/assets/k3s.png" style="height: 100px; width: auto;">
  <img src="./docs/assets/ansible.png" style="height: 100px; width: auto;">
</div>

---

A demo infrastructure for NextCloud running on a self-managed/instaled k3s cluster on Hetzner cx22 instances. Using a sepparate Redis cache and Postgre DB in a seggregated private subnets connected to the main public VPC with the k3s cluster. 

Access to the servers is only allowed with private/public key-pair SSH keys and is automaticaly configured using your existing *~/.ssh/\** and *~/.kube/\** directories (Read the warning prerequisites bellow).

Deployment of nextcloud is done using helm and kubernetes manifests with cert-manager and nginx to ensure TLS/SSL encryption.

:warning: The deployment module is still a work in progress :warning:

---

## Prerequisites

- Install OpenSSH   (For Ansible)
- Install Ansible   (Automation)
- Install Terraform (IaC)
- Install Helm      (Deployments)

:warning: The ansible module modifies the SSH keys directly in the ~/.ssh/* directory :warning:

:warning: The ansible module will overwrite the current ~/.ssh/config configuration :warning:

:warning: The ansible module creates a new ~/.kube/nextcloud_demo_kubeconfig configuration file :warning:

## Automatic documentation generation

Use the following command in the root of this repository to auto-generate the terraform docs for each of the modules:
```bash
for dir in modules/*/; do
    (cd "$dir" && terraform-docs markdown . > README.md)
done
```

---

## Running the demo

To run the demo infrastructure follow the steps bellow:

1. Clone the repository:
```bash
git clone https://github.com/Timotej979/Nextcloud-k8s-demo-infra.git
```

2. Change the directory to the repository root and then to the demo environment:
```bash
cd Nextcloud-k8s-demo-infra/environments/nextcloud-demo/
```

3. Setup the Hetzner API token and AWS credentials:
```bash
export AWS_ACCESS_KEY_ID="your_aws_access_key_id"
export AWS_SECRET_ACCESS_KEY="your_aws_secret_access_key"

touch ./1-hetzner-infrastructure/terraform.tfvars
echo "hcloud_token = \"your_hetzner_api_token\"" > ./1-hetzner-infrastructure/terraform.tfvars
```

4. Execute the environment segments in order:
```bash
# Terraform state bucket and DynamoDB table
cd 0-tfstate/
terraform init
terraform apply

# Hetzner infrastructure setup (VPC, servers, subnets, firewalls, load balancer)
cd ../1-hetzner-infrastructure/
terraform init
terraform apply

# Ansible playbooks for the infrastructure (Install K3S, Postgre DB, Redis cache)
cd ../2-ansible-coonfiguration/
terraform init
terraform apply

# Helm charts for the deployments (Cloud Controller Manager, Cert Manager, Nginx Ingress Controller, Nextcloud)
cd ../3-deployment/
terraform init
terraform apply
```

---

## Infrastructure

The infrastructure of the demo is composed of the following chapters explaining various parts of the infrastructure:
- Used resources (Phyical/Virtual resources)
- Firewall rules
- Architecture explanation
- Code structure

---

### Used resources

- AWS resources (Phyical resources):
  - 1x S3 bucket for the Terraform state
  - 1x DynamoDB table for the Terraform state locking

- Hetzner servers (Phyical resources):
  - 1x cx22 instance for K3S control plane
  - 2x cx22 instances for K3S worker nodes (Can be scaled up or down)
  - 1x cx22 instance for Postgre DB
  - 1x cx22 instance for Redis cache

- Hetzner network (Phyical resources):
  - 1x VPC for the whole infrastructure
  - 1x public subnet for the K3S cluster
  - 1x private subnet for the Postgre DB
  - 1x private subnet for the Redis cache

- Hetzner firewall (Phyical resources):
  - 1x firewall for the K3S control plane
  - 2x firewall for the K3S worker nodes (Can be scaled up or down)
  - 1x firewall for the Postgre DB
  - 1x firewall for the Redis cache

- Hetzner load balancer (Phyical resources):
  - 1x load balancer for the K3S cluster connected to the K3S worker nodes

- Ansible:
  - 1x ansible playbook for the K3S cluster
  - 1x ansible playbook for the Postgre DB
  - 1x ansible playbook for the Redis cache

- Deployment:
  - 1x helm chart for Cloud Controller Manager
  - 1x helm chart for Cert Manager
  - 1x helm chart for Nginx Ingress Controller (Connected to the Hetzner load balancer through annotations)
  - 1x helm chart for Nextcloud

---

### Firewall rules

- K3S control plane:
  - ICMP (Ping) [Any IP]
  - 22   (TCP) - SSH [Any IP]
  - 6443 (TCP) - Kubernetes API server [Any IP]
  - 2379 - 2380 (TCP) - etcd server client API [Public subnet]
  - 10250 (TCP) - Kubelet API [Public subnet]
  - 10255 (TCP) - Read-Only Kubelet API [Public subnet]
  - 8472  (UDP) - Flannel VXLAN [Public subnet]

- K3S worker nodes:
  - ICMP (Ping) [Any IP]
  - 22   (TCP) - SSH [Any IP]
  - 80   (TCP) - HTTP [Hetzner load balancer]
  - 443  (TCP) - HTTPS [Hetzner load balancer]
  - 8080 (TCP) - HTTP [Hetzner load balancer]
  - 6444 (TCP) - Kubelet API [Public subnet]
  - 10250 (TCP) - Kubelet API [Public subnet]
  - 10255 (TCP) - Read-Only Kubelet API [Public subnet]
  - 8472  (UDP) - Flannel VXLAN [Public subnet]

- Postgre DB:
  - ICMP (Ping) [Public subnet]
  - 22   (TCP) - SSH [Public subnet]
  - 5432 (TCP) - Postgre DB [Public subnet]

- Redis cache:
  - ICMP (Ping) [Public subnet]
  - 22   (TCP) - SSH [Public subnet]
  - 6379 (TCP) - Redis cache [Public subnet]

---

### Architecture explanation

The architecture of the demo infrastructure is shown in the following diagram:

<div align="center">
  <img src="./docs/assets/arch.png" width="1300">
</div>

Two details which is worth mentioning are:
- The Postgre DB and Redis cache installation are done through Ansible using a bastion host (control plane) to connect to the private subnets since they are not directly accessible from the public subnet
- The Hetzner load balancer is connected to the K3S worker nodes through annotations in the Nginx Ingress Controller helm chart

---

### Code structure

The code structure of the project is modularized in the following way:
- `environments/` - General environments for different types of deployments (dev, prod, etc.)
  - `nextcloud-demo/` - Nextcloud demo environment
    - `0-tfstate` - Terraform state bucket and DynamoDB table
    - `1-hetzner-infrastructure` - Hetzner infrastructure setup (VPC, servers, subnets, firewalls, load balancer)
    - `2-ansible-coonfiguration` - Ansible playbooks for the infrastructure (Install K3S, Postgre DB, Redis cache)
    - `3-deployment` - Helm charts for the deployments (Cloud Controller Manager, Cert Manager, Nginx Ingress Controller, Nextcloud)

- `modules/` - Terraform modules for the infrastructure
  - `tfstate/` - Terraform state bucket and DynamoDB table
  - `hetzner/` - Hetzner infrastructure setup (VPC, servers, subnets, firewalls, load balancer)
  - `ansible/` - Ansible playbooks for the infrastructure (Install K3S, Postgre DB, Redis cache)
  - `deployment/` - Helm charts for the deployments (Cloud Controller Manager, Cert Manager, Nginx Ingress Controller, Nextcloud)