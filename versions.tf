terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    flux = {
      source  = "fluxcd/flux"
    }
  }
  required_version = ">= 1.0"
}
