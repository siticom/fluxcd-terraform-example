terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    flux = {
      source  = "fluxcd/flux"
    }
  }
  required_version = ">= 1.0"
}
