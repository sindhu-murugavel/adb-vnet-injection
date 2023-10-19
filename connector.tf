resource "azurerm_databricks_access_connector" "example" {
  name                = "wegmansuc-databricks-mi"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  location            = data.azurerm_resource_group.existing_rg.location
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
}


resource "azurerm_role_assignment" "example" {
  scope                = azurerm_storage_account.example.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.example.identity[0].principal_id
}