provider "azurerm" {
    features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

# Create an App Service Plan
resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
  }
}

# Create an Azure Key Vault
resource "azurerm_key_vault" "example" {
  name                = "examplekeyvault"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  enabled_for_disk_encryption = true
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "get",
      "list",
    ]
  }
}

# Create a Web App
resource "azurerm_app_service" "example" {
  name                = "example-webapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    always_on = true

    app_settings = [
      {
        name  = "STORAGE_ACCOUNT_NAME"
        value = azurerm_storage_account.example.name
      },
      {
        name  = "KEY_VAULT_NAME"
        value = azurerm_key_vault.example.name
      },
    ]
  }

  identity {
    type = "SystemAssigned"
  }
}

# Output the Web App URL
output "webapp_url" {
  value = azurerm_app_service.example.default_site_hostname
}
