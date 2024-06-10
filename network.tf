resource "azurerm_virtual_network" "ntier-vnet" {
  name                = "ntier-vnet"
  resource_group_name = azurerm_resource_group.ntier-resg.name
  address_space       = [var.virtual_network_cidr]
  location            = azurerm_resource_group.ntier-resg.location

  depends_on = [
    azurerm_resource_group.ntier-resg
  ]

}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntier-resg.name
  virtual_network_name = azurerm_virtual_network.ntier-vnet.name
  address_prefixes     = [cidrsubnet(var.virtual_network_cidr, 8, count.index)]

  depends_on = [
    azurerm_resource_group.ntier-resg,
    azurerm_virtual_network.ntier-vnet
  ]

}