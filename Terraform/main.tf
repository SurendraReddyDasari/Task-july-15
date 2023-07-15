provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  resource_group_name         = azurerm_resource_group.example.name
  location                    = azurerm_resource_group.example.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_app_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_linux_web_app" "example" {
  name                      = "example-web-app"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  app_service_plan_id       = azurerm_app_service_plan.example.id
  app_settings              = { "SOME_KEY" = "SOME_VALUE" }
  client_affinity_enabled   = false
  always_on                 = true
  connection_string         = azurerm_key_vault_secret.example_connection_string.id
  https_only                = true
  min_tls_version           = "1.2"
  ftps_state                = "Disabled"
  use_32_bit_worker_process = false

  site_config {
    always_on               = true
    linux_fx_version        = "DOCKER|nginx"
    use_32_bit_worker_process = false
  }
}

resource "azurerm_key_vault_secret" "example_connection_string" {
  name         = "ExampleConnectionString"
  value        = azurerm_storage_account.example.primary_connection_string
  key_vault_id = azurerm_key_vault.example.id
}
