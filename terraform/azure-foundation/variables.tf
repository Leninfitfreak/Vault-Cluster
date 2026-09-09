variable "project_name" {
  description = "Project name used in Azure resource naming"
  type        = string
  default     = "vault-poc"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "Central India"
}

variable "region_short" {
  description = "Short region code used in resource names"
  type        = string
  default     = "cin"
}

variable "tags" {
  description = "Common tags applied to Azure resources"
  type        = map(string)

  default = {
    environment = "dev"
    project     = "vault-poc"
    managed_by  = "terraform"
    owner       = "devops"
  }
}
