terraform {
  required_providers {
    azurerm = {
      version = "~>3.0.0"
      source  = "hashicorp/azurerm"
    }
  }
}

resource "azurerm_storage_account" "ast" {
  name                     = var.resource_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags = {
    environment = "staging"
  }
}
