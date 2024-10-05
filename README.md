# Nextcloud-k8s-demo-infra

A demo infrastructure for NextCloud running on a self-managed/instal;ed k3s cluster on Hetzner cx22 instances.

TODO: Add infrastructure description once done

## Automatic documentation generation

Use the following command in the root of this repository to auto-generate the terraform docs for each of the modules:
```bash
for dir in modules/*/; do
    (cd "$dir" && terraform-docs markdown . > README.md)
done
```
