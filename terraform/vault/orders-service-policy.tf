resource "vault_policy" "orders_service" {
  name = "orders-service"

  policy = <<-EOT
    path "kv/data/ha-test" {
      capabilities = ["read"]
    }

    path "database/creds/orders-service" {
      capabilities = ["read"]
    }

    path "kv/data/orders-service" {
      capabilities = ["read"]
    }
  EOT
}