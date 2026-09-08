resource "vault_mount" "pki_root" {
  path                      = "pki-root"
  type                      = "pki"
  description               = "Root PKI for local Vault POC"
  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds     = 315360000
}

resource "vault_pki_secret_backend_root_cert" "root" {
  depends_on = [vault_mount.pki_root]

  backend     = vault_mount.pki_root.path
  type        = "internal"
  common_name = "Vault Local Root CA"
  ttl         = 315360000
  key_type    = "rsa"
  key_bits    = 4096
}

resource "vault_mount" "pki_intermediate" {
  path                      = "pki"
  type                      = "pki"
  description               = "Intermediate PKI for application certificates"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 31536000
}

resource "vault_pki_secret_backend_intermediate_cert_request" "intermediate" {
  depends_on = [vault_mount.pki_intermediate]

  backend     = vault_mount.pki_intermediate.path
  type        = "internal"
  common_name = "Vault Local Intermediate CA"
  key_type    = "rsa"
  key_bits    = 4096
}

resource "vault_pki_secret_backend_root_sign_intermediate" "intermediate" {
  depends_on = [
    vault_pki_secret_backend_root_cert.root,
    vault_pki_secret_backend_intermediate_cert_request.intermediate
  ]

  backend = vault_mount.pki_root.path

  csr         = vault_pki_secret_backend_intermediate_cert_request.intermediate.csr
  common_name = "Vault Local Intermediate CA"
  ttl         = 157680000
  format      = "pem_bundle"
}

resource "vault_pki_secret_backend_intermediate_set_signed" "intermediate" {
  depends_on = [vault_pki_secret_backend_root_sign_intermediate.intermediate]

  backend     = vault_mount.pki_intermediate.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.intermediate.certificate
}

resource "vault_pki_secret_backend_config_urls" "intermediate" {
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.intermediate]

  backend = vault_mount.pki_intermediate.path

  issuing_certificates = [
    "https://vault.local:8300/v1/pki/ca"
  ]

  crl_distribution_points = [
    "https://vault.local:8300/v1/pki/crl"
  ]
}

resource "vault_pki_secret_backend_role" "orders_service" {
  depends_on = [vault_pki_secret_backend_intermediate_set_signed.intermediate]

  backend = vault_mount.pki_intermediate.path
  name    = "orders-service"

  allowed_domains = [
    "orders.local"
  ]

  allow_bare_domains          = true
  allow_subdomains            = false
  allow_ip_sans               = false
  allow_localhost             = false
  allow_wildcard_certificates = false

  server_flag = true
  client_flag = false

  key_type = "rsa"
  key_bits = 2048

  ttl     = 3600
  max_ttl = 86400
}