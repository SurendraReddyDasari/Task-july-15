resource "azurerm_service_plan" "asp" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.rg_name
  kind                = "Linux"
  reserved            = true
  os_type             = "Linux"


}