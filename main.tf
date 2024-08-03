resource "azurerm_resource_group" "demo_rg" {
  name     = "demo-rg"
  location = "UK South"
}

# # Creating resource just to make storage account name unique
# resource "random_string" "sa_random_name" {
#   length  = 16
#   special = false
#   upper   = false
# }

# resource "azurerm_storage_account" "lara_sa" {
#   name                     = "lara${random_string.sa_random_name.id}"
#   resource_group_name      = azurerm_resource_group.demo_rg.name
#   location                 = azurerm_resource_group.demo_rg.location
#   account_tier             = "Standard"
#   account_replication_type = "ZRS"
# }

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "lara_vnet"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "demo_subnet" {
  name                 = "lara_subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

}
resource "azurerm_public_ip" "demo_ip" {
  name                = "lara_ip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "demo_nic" {
  name                = "lara_nic"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "lara_ip-conf"
    subnet_id                     = azurerm_subnet.demo_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.demo_ip.id
  }
}