variable "fluxcd_cluster" {
  type        = string
  description = "name of the cluster"
  default     = "example"
}

variable "fluxcd_known_hosts" {
  type        = string
  description = "SSH known hosts file content. Use `ssh-keyscan git.example.com` to fetch host keys for a server"
}

variable "fluxcd_repo_url" {
  type        = string
  description = "SSH repository url, e.g. `ssh://git@github.com:22/exmaple-org/example.git`"
}

variable "fluxcd_branch" {
  default = "main"
}


