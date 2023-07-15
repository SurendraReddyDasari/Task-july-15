variable "rg_name" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."  
  default = "techslate-ade-rg"
}

variable "location" {
    description =  "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."    
    default = "northeurope"  
}

variable "tags" {
    description =  "(Optional) A mapping of tags which should be assigned to the Resource Group."
    default = {  
      "source" = "terraform"
      "env"    = "dev"
      "cost"   = "163"
      "dept"   = "finance"
    }
}


variable "kv_name" {
  description = ""
  default = "techslate-ade-kv0012"
}

variable "st_name" {
  description = "(Required) Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  default = "techslatestorage0012"
}

variable "asp_name" {
  description = ""
  default = "techslate-asp-0012"
}

variable "webapp_name" {
  description = ""
  default = "techslate-webapp-0012"
}

variable "storage_account_access_key" {
    default = "techslate-web-0012"
}