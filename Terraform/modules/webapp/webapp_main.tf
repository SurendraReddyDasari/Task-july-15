resource "azurerm_linux_web_app" "example" {
  name                      = var.webapp_name
  location                  = var.location
  resource_group_name       = var.rg_name
  service_plan_id           = var.service_plan_id
  app_settings              = var.app_settings
  client_affinity_enabled   = var.client_affinity_enabled
  https_only                = var.https_only
  
 
  site_config {
    always_on               = var.always_on
   
  }
} 