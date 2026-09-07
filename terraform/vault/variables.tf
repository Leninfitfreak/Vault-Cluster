variable "vault_address" {
  description = "External Vault HTTPS endpoint"
  type        = string
}

variable "vault_ca_cert_file" {
  description = "Local path to the Vault CA certificate"
  type        = string
}

variable "kubernetes_host" {
  description = "Kubernetes API server endpoint used by Vault Kubernetes auth"
  type        = string
}

variable "postgresql_username" {
  description = "PostgreSQL management username used by Vault"
  type        = string
  sensitive   = true
}

variable "postgresql_password" {
  description = "PostgreSQL management password used by Vault"
  type        = string
  sensitive   = true
}