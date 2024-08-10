resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name                  = "${local.resource_name_prefix}-web-linux-vm"
  resource_group_name   = azurerm_resource_group.demo_rg.name
  location              = var.location
  size                  = "Standard_D1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
  admin_ssh_key {
    username = "azureuser"
    #This is created within the directory, but not checked into git
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    #Skipping creating a os disk name 
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9.3-gen1"
    version   = "latest"
  }  
}