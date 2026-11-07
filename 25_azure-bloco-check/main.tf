terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.13.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "gasfgrvterraformstate"
    container_name       = "remote-state"
    key                  = "block-check/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}