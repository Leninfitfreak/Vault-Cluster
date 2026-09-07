resource "vault_policy" "postgresql_bootstrap" {
  name = "orders-postgresql-bootstrap"

  policy = <<-EOT
    path "kv/data/orders-service/postgresql-bootstrap" {
      capabilities = ["read"]
    }
  EOT
}

resource "vault_kubernetes_auth_backend_role" "postgresql_bootstrap" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "orders-postgresql-bootstrap"
  bound_service_account_names      = ["postgresql"]
  bound_service_account_namespaces = ["orders"]
  token_policies                   = [vault_policy.postgresql_bootstrap.name]
  token_ttl                        = 3600
}