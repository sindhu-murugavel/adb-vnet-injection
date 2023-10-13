
resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  private_endpoint_network_policies_enabled = true
}

resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}


resource "azurerm_private_endpoint" "example" {
  name                = "${local.prefix}-private-endpoint"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  subnet_id           = azurerm_subnet.endpoint.id
  tags                = local.tags

  private_service_connection {
    name                           = "${local.prefix}-privateserviceconnection"
    //private_connection_resource_id = azurerm_private_link_service.example.id
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names = ["dfs"]
    is_manual_connection           = false
  }
}