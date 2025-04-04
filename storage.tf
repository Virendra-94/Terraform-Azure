terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

# configuring  the Azure Provider
provider "azurerm" {
  subscription_id = "d45d5d5b-2bc2-4f9b-a82b-3a2e6608afb5"
  tenant_id       = "7a325369-5eda-4d37-803c-18c97c3527ef"

  features {}
  resource_provider_registrations = "none"
}

# Creating a new resource group
resource "azurerm_resource_group" "new_rg" {
  name     = "NewStorageResourceGroupViren"
  location = "East US"
}

# Creating a Storage Account with a new name 
resource "azurerm_storage_account" "new_storage" {
  name                     = "virendrakrstorage"
  resource_group_name      = azurerm_resource_group.new_rg.name
  location                 = azurerm_resource_group.new_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "TerraformDemo"
  }
}

# Creating a storage container with a new name

resource "azurerm_storage_container" "new_container" {
  name                  = "virenkrcontainer"
  storage_account_id    = azurerm_storage_account.new_storage.id
  container_access_type = "private"

}
