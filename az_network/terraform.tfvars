//networking
virtual_network_name = "app"
location             = "eastus"
resource_group_name  = "app"
address_space        = ["192.168.0.0/16"]
subnet_name          = "subnet"
subnet_prefix_count = [1,2]
public_ip_name = "pip-nic"
network_interface_name = "app-nic"
network_security_group_name = "app-nsg"
vm_size = "Standard_D1s_v4"

//keyvault
key_permissions = ["Get","Delete","Decrypt","Import","List","Recover","Restore","Update","Verify"]
secret_permissions = ["Backup","Delete","Get", "List","Purge","Recover","Restore","Set"]
storage_permissions = ["Backup","Delete","Get", "List", "Purge", "Recover","Restore", "Set","Update"]
certificate_permissions = ["Backup","Create","Delete","Get","Import", "List", "Purge", "Recover", "Restore","Update"]
ssh_secret_name = "appkey"
kv_sku_name = "standard"
key_vault_name = "app-kv01"
  

//vm
admin_username = "murali"
virtual_machine_name = "appserver01"
managed_disk_type = "Standard_LRS"
os_disk_name = "apposdisk"


//security rules

nsg_security_rule = [
    {
        name                       = "Allow Inbound SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    },
    {
        name                       = "Allow Inbound http"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

]