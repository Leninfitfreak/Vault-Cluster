resource "vault_kubernetes_auth_backend_role" "orders_service" {
  backend   = vault_auth_backend.kubernetes.path
  role_name = "orders-service"

  bound_service_account_names = [
    "vault-auth"
  ]

  bound_service_account_namespaces = [
    "vault-integration"
  ]

  token_policies = [
    "orders-service"
  ]

  token_ttl = 3600
}