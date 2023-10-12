locals {
  tags = {
    environment      = "test"
    application_type = "app"
    subscription     = "stage"
  }
}


terraform {
  required_providers {
    azurerm = {
      version = "~>3.0.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}