terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg-vir"
    storage_account_name = "terraformvirenstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
