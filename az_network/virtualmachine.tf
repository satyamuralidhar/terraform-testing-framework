
  
resource "azurerm_virtual_machine" "avm" {
  name                  = lower(substr(var.virtual_machine_name,0,12))
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size #"Standard_D1s_v4"

  tags = local.tags

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = var.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type # "Standard_LRS"
  }
  

  os_profile_linux_config {
    disable_password_authentication = true
  }

  os_profile_secrets {
    source_vault_id = azurerm_key_vault.kv.id
    vault_certificates {
      certificate_url = azurerm_key_vault_secret.kvsecret.value
    }
  }



  
}
