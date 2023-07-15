resource "azurerm_linux_web_app" "example" {
  name                      = var.webapp_name
  location                  = var.location
  resource_group_name       = var.rg_name
  app_service_plan_id       = var.app_service_plan_id
  app_settings              = var.app_settings
  client_affinity_enabled   = var.client_affinity_enabled
  always_on                 = var.always_on
  https_only                = var.https_only
  min_tls_version           = var.min_tls_version
  ftps_state                = var.ftps_state
  use_32_bit_worker_process = var.use_32_bit_worker_process
  storage_account_name       = var.st_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    always_on               = var.always_on
    linux_fx_version        = var.linux_fx_version
    use_32_bit_worker_process = var.use_32_bit_worker_process
  }
}