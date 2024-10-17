# Nextcloud-k8s-demo-infra

A demo infrastructure for NextCloud running on a self-managed/instal;ed k3s cluster on Hetzner cx22 instances.

TODO: Add infrastructure description/documentation once done

# Prerequisites

- Install OpenSSH   (For Ansible)
- Install SSHPass   (For Ansible SSH session passing)
- Install Ansible   (Automation)
- Install Terraform (IaC)

!! WARNING: Some modules modify the SSH keys directly in the ~/.ssh/* directory and recreate the SSH config file. Please back up any configurations you might have and make sure the SSH key naming conventions do not conflict !!

## Automatic documentation generation

Use the following command in the root of this repository to auto-generate the terraform docs for each of the modules:
```bash
for dir in modules/*/; do
    (cd "$dir" && terraform-docs markdown . > README.md)
done
```
