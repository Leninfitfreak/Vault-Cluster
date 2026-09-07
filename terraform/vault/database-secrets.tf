resource "vault_mount" "database" {
  path        = "database"
  type        = "database"
  description = "Database secrets engine for dynamic application credentials"
}

resource "vault_database_secret_backend_connection" "postgresql" {
  backend       = vault_mount.database.path
  name          = "orders-postgresql"
  allowed_roles = ["orders-service"]

  postgresql {
    connection_url = "postgresql://{{username}}:{{password}}@192.168.49.2:30432/orders?sslmode=disable"

    username = var.postgresql_username

    password_wo         = var.postgresql_password
    password_wo_version = 2
  }
}

resource "vault_database_secret_backend_role" "orders_service" {
  backend = vault_mount.database.path
  name    = "orders-service"

  db_name = vault_database_secret_backend_connection.postgresql.name

  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT CONNECT ON DATABASE orders TO \"{{name}}\";"
  ]

  default_ttl = 3600
  max_ttl     = 86400
}