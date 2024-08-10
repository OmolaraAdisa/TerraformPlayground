locals {
  resource_name_prefix = "${var.location_prefix}-${var.environment}-${var.resource_owner}"
  # Created to have multiple ports and priorities open for the network security rule
  # Reminder to create a network security rule with multiple maps in another session
  web_inbound_map = {
    "100" : "80", #If the key starts with a no, we use a colon and not equals to for assignment
    "110" : "443",
    "120" : "22"
  }

  db_inbound_map = {
    "100" : "3306", #If the key starts with a no, we use a colon and not equals to for assignment
    "110" : "1443",
    "120" : "5432"
  }

  app_inbound_map = {
    "100" : "80", #If the key starts with a no, we use a colon and not equals to for assignment
    "110" : "443",
    "120" : "8080",
    "130" : "22"
  }

  bastion_inbound_map = {
    "100" : "22", #If the key starts with a no, we use a colon and not equals to for assignment
    "110" : "3389"
  }
}