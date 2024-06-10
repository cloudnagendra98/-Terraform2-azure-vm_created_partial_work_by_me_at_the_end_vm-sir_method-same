resource_group       = "ntier-qa"
location             = "eastus"
virtual_network_cidr = "10.0.0.0/16"
subnet_names         = ["web", "app", "db", "mgmt"]
webnsg_config = {
  name = "webnsg"
  rules = [{
    name                       = "openhttp"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = 80
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"
    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_port_range     = 22
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
  }]
}

appnsg_config = {
  name = "appnsg"
  rules = [{
    name                       = "open8080"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = 8080
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"
    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_port_range     = 22
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
  }]
}

dbnsg_config = {
  name = "dbnsg"
  rules = [{
    name                       = "open5000"
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = 5000
    destination_address_prefix = "*"
    access                     = "Allow"
    priority                   = "300"
    direction                  = "Inbound"

    },
    {
      name                       = "openssh"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_port_range     = 22
      destination_address_prefix = "*"
      access                     = "Allow"
      priority                   = "310"
      direction                  = "Inbound"
    }
  ]
}

db_info = {
  db_name        = "employer"
  server_name    = "sqlserverfromtf"
  server_version = "12.0"
  user_name      = "Dell"
  password       = "my@India@123"
  max_size_gb    = 2
  sku_name       = "Basic"
}