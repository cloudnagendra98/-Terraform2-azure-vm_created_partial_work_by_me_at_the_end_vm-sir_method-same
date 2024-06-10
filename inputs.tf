variable "resource_group" {
  type        = string
  default     = "ntier"
  description = "This is azure resource group"

}

variable "location" {
  type        = string
  default     = "eastus"
  description = "This is resource group location"

}

variable "virtual_network_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "This is virtual network cidr range"

}

# variable "subnet_cidr_ranges" {
#   type        = string
#   default     = "10.0.%g.0/24"
#   description = "This is subnets cidr range"

# }


variable "subnet_names" {
  type        = list(string)
  default     = ["web", "app", "db"]
  description = "This is subnet names"

}

variable "webnsg_config" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
      destination_port_range     = number
      destination_address_prefix = string
      access                     = string
      priority                   = string
      direction                  = string
    }))
  })
  default = {
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


}

variable "appnsg_config" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
      destination_port_range     = number
      destination_address_prefix = string
      access                     = string
      priority                   = string
      direction                  = string
    }))
  })
  default = {
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


}

variable "dbnsg_config" {
  type = object({
    name = string
    rules = list(object({
      name                       = string
      protocol                   = string
      source_address_prefix      = string
      source_port_range          = string
      destination_port_range     = number
      destination_address_prefix = string
      access                     = string
      priority                   = string
      direction                  = string
    }))
  })
  default = {
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
    }]

  }
}


variable "db_info" {
  type = object({
    db_name        = string
    server_name    = string
    server_version = string
    user_name      = string
    password       = string
    max_size_gb    = number
    sku_name       = string


  })
  default = {
    db_name        = "employer"
    server_name    = "sqlserverfromtf"
    server_version = "12.0"
    user_name      = "Dell"
    password       = "my@India@123"
    max_size_gb    = 2
    sku_name       = "Basic"


  }


}

variable "appvm_config" {
  type = object({
    subnet_name = string
    # public_ip_name                = string
    # allocation_method             = string
    # network_interface_name        = string
    # network_interface_ip_name     = string
    # private_ip_address_allocation = string
    # appvm_name                    = string
    size           = string
    admin_username = string
    #key_name                      = string ##This is actually username i misunderstood initially further explanation go to appvm.tf
    public_key_path      = string
    os_disk_caching      = string
    storage_account_type = string
    publisher            = string
    offer                = string
    sku                  = string
    version              = string



  })
  default = {
    subnet_name = "app"
    # public_ip_name                = "app_public_ip"
    # allocation_method             = "Static"
    # network_interface_name        = "appnic"
    # network_interface_ip_name     = "app_private_ip"
    # private_ip_address_allocation = "Dynamic"
    # appvm_name                    = "app"
    size           = "Standard_B1s"
    admin_username = "Dell"
    #key_name                      = "my_id_rsa.pub" #This is actually username i misunderstood initially further explanation go to appvm.tf
    public_key_path      = "~/.ssh/id_rsa.pub"
    os_disk_caching      = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "0001-com-ubuntu-server-jammy"
    sku                  = "22_04-lts-gen2"
    version              = "latest"
  }

}