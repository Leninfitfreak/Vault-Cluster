resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
  path = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend = vault_auth_backend.kubernetes.path

  kubernetes_host    = var.kubernetes_host
  kubernetes_ca_cert = file("D:/Vault/runtime/k8s-ca.crt")

  disable_local_ca_jwt = true
}