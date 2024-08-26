resource "azurerm_resource_group" "demo_rg" {
  name     = "${local.resource_name_prefix}-rg"
  location = var.location
}

# # Creating resource just to make storage account name unique for practise not for production scenario
# resource "random_string" "sa_random_name" {
#   length  = 16
#   special = false
#   upper   = false
# }

# resource "azurerm_storage_account" "lara_sa" {
#   name                     = "lara${random_string.sa_random_name.id}"
#   resource_group_name      = azurerm_resource_group.demo_rg.name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "ZRS"
# }

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "${local.resource_name_prefix}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name
  address_space       = var.vnet_address_space
}

# Web server subnet and other config
resource "azurerm_subnet" "web_subnet" {
  name                 = "${local.resource_name_prefix}-web-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = var.web_subnet_address
}

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${local.resource_name_prefix}-web-subnet-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.web_subnet_nsg_rule_inbound]
}

# Ports to Open 80,443,22
resource "azurerm_network_security_rule" "web_subnet_nsg_rule_inbound" {
  for_each                    = local.web_inbound_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.demo_rg.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}


# Database subnet and other config
resource "azurerm_subnet" "db_subnet" {
  name                 = "${local.resource_name_prefix}-db-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = var.db_subnet_address
}

resource "azurerm_network_security_group" "db_subnet_nsg" {
  name                = "${local.resource_name_prefix}-db-subnet-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name
}

resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.db_subnet_nsg_rule_inbound]
}

# Ports to Open 3306,1443,5432
resource "azurerm_network_security_rule" "db_subnet_nsg_rule_inbound" {
  for_each                    = local.db_inbound_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.demo_rg.name
  network_security_group_name = azurerm_network_security_group.db_subnet_nsg.name
}


# Bastion subnet and other config
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${local.resource_name_prefix}-bastion-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = var.bastion_subnet_address
}

resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name                = "${local.resource_name_prefix}-bastion-subnet-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name

}

resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.bastion_subnet_nsg_rule_inbound]
}

# Ports to Open 22,3389
resource "azurerm_network_security_rule" "bastion_subnet_nsg_rule_inbound" {
  for_each                    = local.bastion_inbound_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.demo_rg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

# App subnet and other config
resource "azurerm_subnet" "app_subnet" {
  name                 = "${local.resource_name_prefix}-app-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = var.app_subnet_address
}

resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "${local.resource_name_prefix}-app-subnet-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name

}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
  depends_on                = [azurerm_network_security_rule.app_subnet_nsg_rule_inbound]
}

# Ports to Open 80,443,8080,22
resource "azurerm_network_security_rule" "app_subnet_nsg_rule_inbound" {
  for_each                    = local.app_inbound_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.demo_rg.name
  network_security_group_name = azurerm_network_security_group.app_subnet_nsg.name
}

resource "azurerm_public_ip" "web_linuxvm_public_ip" {
  name                = "${local.resource_name_prefix}-web-linux-publicip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "web_linuxvm_nic" {
  name                = "${local.resource_name_prefix}-web-linux-vmnic"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "web-linux-vmip-conf"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_linuxvm_public_ip.id
  }
}

resource "azurerm_public_ip" "bastion_host_public_ip" {
  name                = "${local.resource_name_prefix}-bastion-host-publicip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = var.location
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_network_interface" "bastion_host_linuxvm_nic" {
  name                = "${local.resource_name_prefix}-bastion-host-linux-vmnic"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "bastion-vmip-conf"
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_public_ip.id
  }
}