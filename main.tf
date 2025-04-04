provider "azurerm" {
  subscription_id = "5ec7926b-c3e7-4478-958b-fdb3243a8f23"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-rg-vir"
  location = "East US"
}

resource "azurerm_storage_account" "storage" {
  name                     = "terraformvirenstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
