resource "azurerm_storage_account" "dummy" {
  name                     = "${local.prefix}stg2"
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"
  is_hns_enabled           = true
  //public_network_access_enabled   = false
  tags = local.tags

}


resource "azurerm_storage_container" "dummy" {
  name                  = "mycontainerdummy"
  storage_account_name  = azurerm_storage_account.dummy.name
  container_access_type = "private" # You can set access type as per your requirements
}

resource "azurerm_storage_account_network_rules" "dummy" {
  storage_account_id = azurerm_storage_account.dummy.id

  default_action = "Deny"
  virtual_network_subnet_ids = [azurerm_subnet.public-dummy.id, azurerm_subnet.private-dummy.id,
    "/subscriptions/23a8c420-c354-43f9-91f5-59d08c6b3dff/resourceGroups/prod-canadacentral-snp-1-compute-4/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-4/subnets/worker-subnet",
    "/subscriptions/31ef391b-7908-48ec-8c74-e432113b607b/resourceGroups/prod-canadacentral-snp-1-compute-2/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-2/subnets/worker-subnet",
    "/subscriptions/56beece1-dbc8-40ca-8520-e1d514fb2ccc/resourceGroups/prod-canadacentral-snp-1-compute-9/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-9/subnets/worker-subnet",
    "/subscriptions/653c13e3-a85b-449b-9d14-e3e9c4b0d391/resourceGroups/prod-canadacentral-snp-1-compute-7/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-7/subnets/worker-subnet",
    "/subscriptions/6c0d042c-6733-4420-a3cc-4175d0439b29/resourceGroups/prod-canadacentral-snp-1-compute-3/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-3/subnets/worker-subnet",
    "/subscriptions/8453a5d5-9e9e-40c7-87a4-0ab4cc197f48/resourceGroups/prod-canadacentral-snp-1-compute-1/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-1/subnets/worker-subnet",
    "/subscriptions/9d5fffc7-7640-44a1-ba2b-f77ada7731d4/resourceGroups/prod-canadacentral-snp-1-compute-6/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-6/subnets/worker-subnet",
    "/subscriptions/b4f59749-ad17-4573-95ef-cc4c63a45bdf/resourceGroups/prod-canadacentral-snp-1-compute-10/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-10/subnets/worker-subnet",
    "/subscriptions/b96a1dc5-559f-4249-a30c-5b5a98023c45/resourceGroups/prod-canadacentral-snp-1-compute-8/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-8/subnets/worker-subnet",
  "/subscriptions/d31d7397-093d-4cc4-abd6-28b426c0c882/resourceGroups/prod-canadacentral-snp-1-compute-5/providers/Microsoft.Network/virtualNetworks/prod-canadacentral-snp-1-compute-5/subnets/worker-subnet"]
  bypass = ["AzureServices"]

  private_link_access {
    endpoint_resource_id = azurerm_databricks_access_connector.example.id

  }

}