# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

/*provider "databricks" {
  host = azurerm_databricks_workspace.example.workspace_url
  azure_workspace_resource_id = azurerm_databricks_workspace.example.id
  //username = var.databricks_account_username
  //password = var.databricks_account_password

  //azuread_app_id  = "1c71b68c-471b-4672-9ab7-2a0de5de8b9c"
  //resource_group_id = "/subscriptions/3f2e4d32-8e8d-46d6-82bc-5bb8d962328b/resourceGroups/sm-uc-test"
  //
  azure_client_id             = "1c71b68c-471b-4672-9ab7-2a0de5de8b9c"
  azure_client_secret         = "8g48Q~UcKRk9exKGE1KHIfIs2S3ZY27k1LrK9cYS"
  azure_tenant_id             = "9f37a392-f0ae-4280-9796-f1864a10effc"

}*/


