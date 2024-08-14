variable "location" {
  description = "Região onde recuros serão criados"
  type        = string
  default     = "West Europe"
}

variable "account_tier" {
  description = "Tier da Storage Account na Azure"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Tipo de replicação de dados da Storage Account"
  type        = string
  default     = "LRS"
}

variable "resource_group_name" {
  description = "Nome para o Resource Group da Azure"
  type        = string
  default     = "rg-curso-terraform"
}

variable "storage_account_name" {
  description = "Nome da Storage Account na Azure"
  type        = string
  default     = "sagasfgrvterraform"
}

variable "container_name" {
  description = "Nome do container na Azure"
  type        = string
  default     = "container-terraform"
}
