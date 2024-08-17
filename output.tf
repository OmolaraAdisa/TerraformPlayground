output "virtual_network_name" {
  description = "Virtual Network Name"
  value       = "azurerm_virtual_network.demo_vnet"
}

output "virtual_network_id" {
  description = "Virtual Network ID"
  value       = "azurerm_virtual_network.demo_vnet.id"
}

output "web_linuxvm_public_ip" {
  description = "Web Linux virtual machine public ip"
  value = azurerm_public_ip.web_linuxvm_public_ip.ip_address
}

output "web_linuxvm_nic" {
  description = "Web Linux virtual machine Network Interface Card"
  value = azurerm_network_interface.web_linuxvm_nic.id
}

output "web_linuxvm_privateip" {
  description = "Web Linux virtual machine Network Private IP"
  value = azurerm_network_interface.web_linuxvm_nic.private_ip_address
}