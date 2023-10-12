/*resource "azurerm_subnet" "service" {
  name                 = "service"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
  private_endpoint_network_policies_enabled = true
}*/

resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
  private_endpoint_network_policies_enabled = true
}

/*
resource "azurerm_public_ip" "example" {
  name                = "${local.prefix}-publicip"
  sku                 = "Standard"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  allocation_method   = "Static"
  tags                = local.tags
}

resource "azurerm_lb" "example" {
  name                = "${local.prefix}-loadbalancer"
  sku                 = "Standard"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = local.tags

  frontend_ip_configuration {
    name                 = azurerm_public_ip.example.name
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_private_link_service" "example" {
  name                = "${local.prefix}-privatelink"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = local.tags

  nat_ip_configuration {
    name      = azurerm_public_ip.example.name
    primary   = true
    subnet_id = azurerm_subnet.service.id
  }

  load_balancer_frontend_ip_configuration_ids = [
    azurerm_lb.example.frontend_ip_configuration.0.id,
  ]
}
*/
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