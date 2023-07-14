terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-remotestate31"
    storage_account_name = "tfstateremote31"
    container_name       = "remotestatetf31"
    key                  = "dev.terraform.tfstate"
  }
}