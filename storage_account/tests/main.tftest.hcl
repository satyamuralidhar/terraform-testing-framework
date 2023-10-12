terraform {
  required_providers {
    azurerm = {
      version = "~>3.0.0"
      source  = "hashicorp/terraform"
    }
  }
}

provider "azurerm" {
  features {}
}


variables {
  resource_name            = "stdaccount0118"
  location                 = "eastus"
  resource_group_name      = "rsg-storage"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#validation test
run "storage_account_variable_validation" {
  command = plan

  variables {
    resource_name            = "stdaccount0118"
    location                 = "eastus"
    resource_group_name      = "rsg-storage"
    account_tier             = "StandardLRS"
    account_replication_type = "LGRS"
  }
  expect_failures = [var.account_tier, var.account_replication_type]

}
//where exactly resources is created on testing phase
run "setup" {
  command = apply
  variables {
    resource_group_name = "staging-rsg"
    location            = "eastus"
  }
  module {
    source = "./tests/setup"
  }
}

// test with plan acutual vs expected test

run "stg_account_attribute_actual_vs_expected_test" {
  command = plan
  variables {
    resource_group_name      = run.setup.resource_group_name
    resource_name            = var.resource_name
    location                 = var.location
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
  }

  assert {
    condition     = azurem_storage_account.ast.name == var.resource_name
    error_message = "Storage account name not matching with given variable name : ${var.resource_name}"
  }

  assert {
    condition     = azurem_storage_account.ast.location == var.location
    error_message = "Storage account location not matching with given variable name : ${var.location} "
  }

  assert {
    condition     = azurem_storage_account.ast.account_tier == var.account_tier
    error_message = "Storage account tier not matching with given variable name : ${var.account_tier} "
  }

  assert {
    condition     = azurem_storage_account.ast.account_replication_type == var.account_replication_type
    error_message = "Storage account replication type not matching with given variable name : ${var.account_replication_type} "
  }

}

//Test with apply


run "stg_account_apply_attribute_actual_vs_expected_test" {
  command = apply
  variables {
    resource_group_name      = run.setup.resource_group_name
    resource_name            = var.resource_name
    location                 = var.location
    account_tier             = var.account_tier
    account_replication_type = var.account_replication_type
  }

  assert {
    condition     = azurem_storage_account.ast.name == var.resource_name
    error_message = "Storage account name not matching with given variable name : ${var.resource_name}"
  }

  assert {
    condition     = azurem_storage_account.ast.location == var.location
    error_message = "Storage account location not matching with given variable name : ${var.location} "
  }

}