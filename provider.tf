terraform {
  required_version = "1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.113.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

#Default Provider
provider "azurerm" {
  features {}
}

#Multiple provider config
#Can be used to add in different region or different subscription name
#Can be used to add in another provider if using Multicloud
# provider "azurerm" {
#   features {}
#   # alias = "needs a name so it is different from the initial provider config"
#   # subscription_id = "this takes the subscription id"
# }