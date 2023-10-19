/*resource "databricks_storage_credential" "mi" {
  name = "mi_credential"
  azure_managed_identity {
    access_connector_id = azurerm_databricks_access_connector.unity.id
  }
  comment = "Managed identity credential managed by TF"
}

resource "databricks_grants" "external_creds" {
  storage_credential = databricks_storage_credential.mi.id
  grant {
    principal  = "Data Engineers"
    privileges = ["CREATE_TABLE"]
  }
}

resource "databricks_external_location" "notroot-managed-location" {
  name = "notroot-managed-location"
  url = format("abfss://%s@%s.dfs.core.windows.net",
    azurerm_storage_container.example.name,
  azurerm_storage_account.example.name)
  credential_name = databricks_storage_credential.mi.id

}*/