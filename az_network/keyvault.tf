
//key vault creation to store keys

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = var.kv_sku_name #"standard"
  tags = local.tags

}


//keyvault access policy 

resource "azurerm_key_vault_access_policy" "kvp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
  key_permissions = var.key_permissions
  secret_permissions = length(var.secret_permissions) !=null ? var.secret_permissions : []
  storage_permissions = length(var.storage_permissions)  !=null ? var.storage_permissions : []
  certificate_permissions = length(var.certificate_permissions) !=null ? var.certificate_permissions : []


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
