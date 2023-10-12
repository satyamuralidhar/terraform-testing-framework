
//key vault creation to store keys

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags = local.tags

}


//keyvault access policy 

resource "azurerm_key_vault_access_policy" "kvp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  dynamic "key_permissions" {
    for_each = var.key_permissions
    iterator = "permissions"
    content {
      key_permissions = permissions.key_permissions
    }
  }
  
  dynamic "key_permissions" {
    for_each = length(var.key_permissions) !="" ? var.key_permissions : ""
    iterator = "permissions"
    content {
      key_permissions = permissions.key_permissions
    }
  }

  dynamic "secret_permissions" {
    for_each = length(var.secret_permissions) !="" ? var.secret_permissions : ""
    iterator = "permissions"
    content {
      key_permissions = permissions.secret_permissions
    }
  }

  dynamic "storage_permissions" {
    for_each = length(var.storage_permissions)  !="" ? var.storage_permissions : ""
    iterator = "permissions"
    content {
      key_permissions = permissions.storage_permissions
    }
  }

  dynamic "certificate_permissions" {
    for_each = length(var.certificate_permissions) !="" ? var.certificate_permissions : ""
    iterator = "permissions"
    content {
      key_permissions = permissions.certificate_permissions
    }
  }

  

/*
Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify,
*/
  # key_permissions = [
  #   "Get","Delete","Decrypt","Get","Import","List","Recover","Restore","Update","Verify"
  # ]

  # secret_permissions = [
  #   "Get",
  # ]
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "kvsecret" {
  name         = var.ssh_secret_name
  value        = tls_private_key.rsa.public_key_openssh
  key_vault_id = azurerm_key_vault.kv.id
}
