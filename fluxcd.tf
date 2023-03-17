data "flux_sync" "main" {
  target_path = "clusters/${var.fluxcd_cluster}"
  url         = var.fluxcd_repo_url
  branch      = var.fluxcd_branch
}

resource "tls_private_key" "fluxcd_ssh_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "kubernetes_secret" "fluxcd_ssh_key" {
  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    identity       = tls_private_key.fluxcd_ssh_key.private_key_pem
    "identity.pub" = tls_private_key.fluxcd_ssh_key.public_key_pem
    known_hosts    = var.fluxcd_known_hosts
  }
}

resource "local_file" "fluxcd_sync" {
  filename        = data.flux_sync.main.path
  content         = data.flux_sync.main.content
  file_permission = "0644"
}

output "fluxcd_ssh_public_key" {
  value = tls_private_key.fluxcd_ssh_key.public_key_openssh
}
