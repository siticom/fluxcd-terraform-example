# FluxCD bootstrap with Terraform

This repository is a template for bootstrapping a FluxCD-managed cluster with Terraform. In contrast to the FluxCD Terraform provider, this example does not use Terraform to manage the FluxCD system components itself, but only the GitRepository resource. This enables FluxCD to update all components by itself and allows using Renovate Bot to update the repository files.

## Prerequirements

- [FluxCD CLI](https://fluxcd.io/flux/installation/#install-the-flux-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)

## Bootstrap Process

Create the `flux-system` folder in your repository and make sure that `<cluster-name>` matches the value of the Terraform variable `fluxcd_cluster`.
```sh
mkdir -p clusters/<cluster-name>/flux-system
```

Next the initialize FluxCD components and deploy them:
```sh
flux install --export > clusters/<cluster-name>/flux-system/gotk-components.yaml
kubectl apply -f clusters/<cluster-name>/flux-system/gotk-components.yaml
```

Then define the Terraform variables and apply the configuration to create the synchronization between the repository and the cluster:
```sh
terraform init
terraform apply
```

Next commit and push all changes in your repository and grant the generated SSH key read access to your repository.
You can find the SSH public key in the Terraform output `fluxcd_ssh_public_key`.

Finally apply the sync resources:
```sh
kubectl apply -f clusters/<cluster-name>/flux-system/gotk-sync.yaml
```

## Renovate Bot

With the Renovate configuration in this repository the bot will check for FluxCD system updates and app resource updates in folders with prefix `cluster-*`. Also image definitions in FluxCD Helm Release values are detected for files called `release.yaml` located in folders with the mentioned prefix.
