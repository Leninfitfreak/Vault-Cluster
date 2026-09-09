locals {
  resource_group_name = "rg-${var.project_name}-${var.environment}-${var.region_short}"

  vnet_name = "vnet-${var.project_name}-${var.environment}-${var.region_short}"

  vault_subnet_name = "snet-vault"

  aks_subnet_name = "snet-aks"

  private_endpoint_subnet_name = "snet-private-endpoints"
}
