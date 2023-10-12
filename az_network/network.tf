resource "azurerm_resource_group" "rsg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s", var.virtual_network_name, "vnet")
  location            = var.location
  resource_group_name = format("%s-%s", var.resource_group_name, "rsg")
  address_space       = var.address_space
  tags                = local.tags
  depends_on = [ azurerm_resource_group.rsg ]
}
resource "azurerm_subnet" "snet" {
  count                = length(var.subnet_prefix_count)
  name                 = format("%s-%s-%s", var.subnet_name, "0", count.index + 1)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(join("",var.address_space), 8, var.subnet_prefix_count[count.index])]
  depends_on = [ 
    azurerm_virtual_network.vnet
    ]
}


//public ip creation 

resource "azurerm_public_ip" "pip" {
  name                = format("%s-%s",var.public_ip_name,"-pip")
  resource_group_name = azurerm_resource_group.rsg.name
  location            = azurerm_resource_group.rsg.location
  allocation_method   = "Static"
  tags = local.tags
  depends_on = [ azurerm_subnet.snet ]
}

//create a nic card on subnet level association 
resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name
  tags = local.tags
  depends_on = [ azurerm_public_ip.pip ]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.snet[1].id
    private_ip_address_allocation = "Static"
    public_ip_address_id = azurerm_public_ip.pip.id
  }

}
# network security rule
resource "azurerm_network_security_group" "nsg" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name
  tags = local.tags

  dynamic "security_rule" {
    for_each = {for k,v in var.nsg_security_rule : k.name => v}
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }

  }
  # security_rule {
  #   name                       = "test123"
  #   priority                   = 100
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }
}
//nsg association
resource "azurerm_network_interface_security_group_association" "nsgassociate" {
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "snetassociate" {
  subnet_id = azurerm_subnet.snet[1].id
  network_security_group_id = azurerm_network_interface.nic.id

}
