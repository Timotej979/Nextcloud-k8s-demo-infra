<h1 align="center">Nextcloud-k8s-demo-infra</h1>


<div align="center">
  <img src="./docs/assets/hetzner.png" width="100">
  <img src="./docs/assets/k3s.png" width="300">
  <img src="./docs/assets/ansible.png" width="100">
</div>

---

A demo infrastructure for NextCloud running on a self-managed/instaled k3s cluster on Hetzner cx22 instances. Using a sepparate Redis cache and Postgre DB in a seggregated private subnets connected to the main publi VPC with the k3s cluster. Access to the servers only allowed with private/public key-pair SSH keys and is automaticaly configured using your existing *~/.ssh/\** and *~/.kube/\** directories (Read the :warning: prerequisites bellow). Deployment of nextcloud is done using helm with cert-manager and nginx to ensure TLS/SSL encryption.

# Prerequisites

- Install OpenSSH   (For Ansible)
- Install Ansible   (Automation)
- Install Terraform (IaC)
- Install Helm      (Deployments)

!! :warning: The ansible module modifies the SSH keys directly in the ~/.ssh/* directory :warning: !!

!! :warning: The ansible module will overwrite the current ~/.ssh/config configuration :warning: !!

!! :warning: The ansible module creates a new ~/.kube/nextcloud_demo_kubeconfig configuration file :warning: !!

## Automatic documentation generation

Use the following command in the root of this repository to auto-generate the terraform docs for each of the modules:
```bash
for dir in modules/*/; do
    (cd "$dir" && terraform-docs markdown . > README.md)
done
```

## Infrastructure architecture

