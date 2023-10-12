resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-%s", var.virtual_network_name, "vnet")
  location            = var.location
  resource_group_name = format("%s-%s", var.resource_group_name, "-rsg")
  address_space       = var.address_space
  tags                = local.tags
}
resource "azurerm_subnet" "snet" {
  count                = length(subnet_prefix_count)
  name                 = format("%s-%s-%s", var.subnet_name, "0", count.index + 1)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = cidrsubnet(var.address_space, 8, count.index)
  tags                 = local.tags
}

# virtual_network_name = ""
# location = ""
# resource_group_name = ""
# address_space = ""
# subnet_name = "appsubnet01"
# address_prefixes = ""
