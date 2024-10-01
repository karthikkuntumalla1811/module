provider "azurerm" {
  features {}

  client_id       = "e6e2b2c1-b4cc-4671-b6d9-40f5ccbc0d23"
  client_secret   = "Skp8Q~al3LpP_8ckvS9AVszIsQlDcxoD1bNdEaZZ"
  tenant_id       = "145f1727-1f1e-46a0-92a5-b8186887d6f6"
  subscription_id = "d718a9ff-83e8-46c2-9475-eb2a17bd9e80"
}

resource "azurerm_resource_group" "kkkrg" {
  name     = var.azurerm_resource_group
  location = var.location

}

resource "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.azurerm_resource_group
   
   depends_on = [azurerm_resource_group.kkkrg]   

}


resource "azurerm_subnet" "subnet1" {
  name                 = var.azurerm_subnet01
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = var.address_prefixes01

   depends_on =[azurerm_virtual_network.vnet]

}

resource "azurerm_subnet" "subnet2" {
  name                 = var.azurerm_subnet02
  resource_group_name  = var.azurerm_resource_group
  virtual_network_name = var.azurerm_virtual_network_name
  address_prefixes     = var.address_prefixes02

   depends_on =[azurerm_virtual_network.vnet]  
}

resource "azurerm_network_security_group" "kkknsg" {
  name                = var.azurerm_network_security_group_name
  location            = var.location
  resource_group_name = var.azurerm_resource_group
  
  depends_on =[azurerm_resource_group.kkkrg]

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

