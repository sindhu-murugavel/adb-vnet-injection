resource "azurerm_storage_account" "example" {
  name                     = "${local.prefix}stg"
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"
  is_hns_enabled = true
  public_network_access_enabled   = false
  tags = local.tags

}


resource "azurerm_storage_container" "example" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"  # You can set access type as per your requirements
}