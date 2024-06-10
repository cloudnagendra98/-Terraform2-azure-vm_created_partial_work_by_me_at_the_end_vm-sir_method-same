resource "azurerm_public_ip" "public_ip" {
  name                = "app_public_ip"
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location
  allocation_method   = "Static"



}

data "azurerm_subnet" "app" {
  name                 = var.appvm_config.subnet_name
  virtual_network_name = azurerm_virtual_network.ntier-vnet.name
  resource_group_name  = azurerm_resource_group.ntier-resg.name

  depends_on = [
    azurerm_virtual_network.ntier-vnet,
    azurerm_subnet.subnets,
    azurerm_public_ip.public_ip
  ]

}

resource "azurerm_network_interface" "nifc" {
  name                = "appnic"
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location
  ip_configuration {
    name                          = "app_private_ip"
    subnet_id                     = data.azurerm_subnet.app.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  depends_on = [
    azurerm_subnet.subnets,
    azurerm_network_security_group.appnsg,
    azurerm_public_ip.public_ip,
    data.azurerm_subnet.app
  ]
}

resource "azurerm_network_interface_security_group_association" "network_interface_app_nsg" {
  network_interface_id      = azurerm_network_interface.nifc.id
  network_security_group_id = azurerm_network_security_group.appnsg.id

  depends_on = [
    azurerm_network_interface.nifc,
  azurerm_network_security_group.appnsg]

}

resource "azurerm_linux_virtual_machine" "appvm" {
  name                = "app"
  resource_group_name = azurerm_resource_group.ntier-resg.name
  location            = azurerm_resource_group.ntier-resg.location
  size                = var.appvm_config.size
  admin_username      = var.appvm_config.admin_username #Note: we must use same name for admin_username = "Dell" here and in username = "Dell " in admin_ssh_key section also below
  network_interface_ids = [
    azurerm_network_interface.nifc.id
  ]
  admin_ssh_key {
    username   = var.appvm_config.admin_username #Note: we must use same name for username = "Dell" here and in username = "Dell " in admin_username just above section to this
    public_key = file(var.appvm_config.public_key_path)
  }

  os_disk {
    caching              = var.appvm_config.os_disk_caching
    storage_account_type = var.appvm_config.storage_account_type
  }

  source_image_reference {
    publisher = var.appvm_config.publisher
    offer     = var.appvm_config.offer
    sku       = var.appvm_config.sku
    version   = var.appvm_config.version
  }

  depends_on = [
    azurerm_public_ip.public_ip,
    azurerm_subnet.subnets,
    data.azurerm_subnet.app,
    azurerm_network_interface.nifc
  ]

}