resource "azurerm_network_security_group" "webnsg" {
  name                = var.webnsg_config.name
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location


  depends_on = [
    azurerm_resource_group.ntier-resg,
    azurerm_virtual_network.ntier-vnet
  ]


}


resource "azurerm_network_security_rule" "webnsg_rules" {
  count                       = length(var.webnsg_config.rules)
  name                        = var.webnsg_config.rules[count.index].name
  resource_group_name         = azurerm_resource_group.ntier-resg.name
  network_security_group_name = azurerm_network_security_group.webnsg.name
  protocol                    = var.webnsg_config.rules[count.index].protocol
  source_address_prefix       = var.webnsg_config.rules[count.index].source_address_prefix
  source_port_range           = var.webnsg_config.rules[count.index].source_port_range
  destination_port_range      = var.webnsg_config.rules[count.index].destination_port_range
  destination_address_prefix  = var.webnsg_config.rules[count.index].destination_address_prefix
  access                      = var.webnsg_config.rules[count.index].access
  priority                    = var.webnsg_config.rules[count.index].priority
  direction                   = var.webnsg_config.rules[count.index].direction

  depends_on = [
    azurerm_network_security_group.webnsg
  ]

}
# resource "azurerm_network_security_rule" "webnsg_rules" {
#   name                        = "openhttp"
#   resource_group_name         = azurerm_resource_group.ntier-resg.name
#   network_security_group_name = azurerm_network_security_group.webnsg.name
#   protocol                    = "Tcp"
#   source_address_prefix       = "*"
#   source_port_range           = "*"
#   destination_port_range      = 80
#   destination_address_prefix  = "*"
#   access                      = "Allow"
#   priority                    = "300"
#   direction                   = "Inbound"

#   depends_on = [
#     azurerm_network_security_group.webnsg
#   ]

# }

resource "azurerm_network_security_group" "appnsg" {
  name                = var.appnsg_config.name
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location

  depends_on = [
    azurerm_resource_group.ntier-resg,
    azurerm_virtual_network.ntier-vnet
  ]


}

resource "azurerm_network_security_rule" "appnsg_rules" {
  count                       = length(var.appnsg_config.rules)
  name                        = var.appnsg_config.rules[count.index].name
  resource_group_name         = azurerm_resource_group.ntier-resg.name
  network_security_group_name = azurerm_network_security_group.appnsg.name
  protocol                    = var.appnsg_config.rules[count.index].protocol
  source_address_prefix       = var.appnsg_config.rules[count.index].source_address_prefix
  source_port_range           = var.appnsg_config.rules[count.index].source_port_range
  destination_port_range      = var.appnsg_config.rules[count.index].destination_port_range
  destination_address_prefix  = var.appnsg_config.rules[count.index].destination_address_prefix
  access                      = var.appnsg_config.rules[count.index].access
  priority                    = var.appnsg_config.rules[count.index].priority
  direction                   = var.appnsg_config.rules[count.index].direction

  depends_on = [
    azurerm_network_security_group.appnsg
  ]

}


resource "azurerm_network_security_group" "dbnsg" {
  name                = var.dbnsg_config.name
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location

  depends_on = [
    azurerm_resource_group.ntier-resg,
    azurerm_virtual_network.ntier-vnet
  ]


}

resource "azurerm_network_security_rule" "dbnsg_rules" {
  count                       = length(var.dbnsg_config.rules)
  name                        = var.dbnsg_config.rules[count.index].name
  resource_group_name         = azurerm_resource_group.ntier-resg.name
  network_security_group_name = azurerm_network_security_group.dbnsg.name
  protocol                    = var.dbnsg_config.rules[count.index].protocol
  source_address_prefix       = var.dbnsg_config.rules[count.index].source_address_prefix
  source_port_range           = var.dbnsg_config.rules[count.index].source_port_range
  destination_port_range      = var.dbnsg_config.rules[count.index].destination_port_range
  destination_address_prefix  = var.dbnsg_config.rules[count.index].destination_address_prefix
  access                      = var.dbnsg_config.rules[count.index].access
  priority                    = var.dbnsg_config.rules[count.index].priority
  direction                   = var.dbnsg_config.rules[count.index].direction

  depends_on = [
    azurerm_network_security_group.dbnsg
  ]

}
