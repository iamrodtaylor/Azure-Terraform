terraform {
  backend "azurerm" {
    storage_account_name  = "tstate25995"
    container_name        = "tstate"
    key                   = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "australiaeast"
}