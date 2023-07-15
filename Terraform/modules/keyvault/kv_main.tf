
resource "azurerm_key_vault" "key_vault" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id = "/subscriptions/ece13a58-9c87-477d-846f-e1d50515d213/resourceGroups/techslate-ade-rg/providers/Microsoft.KeyVault/vaults/techslate-ade-kv0012/objectId/65c4def3-c790-41d9-b50a-630f5ca4b6d9"
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "List",
  ]

  secret_permissions = [
    "Get","List","Set","Delete","Purge"
  ]
}