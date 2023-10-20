resource "azurerm_virtual_network" "dummy" {
  name                = "${local.prefix}-vnet-dummy"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = [var.cidr]
  tags                = local.tags
}

resource "azurerm_network_security_group" "dummy" {
  name                = "${local.prefix}-nsg-dummy"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = local.tags
}

resource "azurerm_subnet" "public-dummy" {
  name                 = "public-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.dummy.name
  //address_prefixes     = [cidrsubnet(var.cidr, 3, 0)]
  address_prefixes                              = [cidrsubnet("10.179.0.0/16", 2, 1)]
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage"]
  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "public-dummy" {
  subnet_id                 = azurerm_subnet.public-dummy.id
  network_security_group_id = azurerm_network_security_group.dummy.id
}

resource "azurerm_subnet" "private-dummy" {
  name                 = "private-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.dummy.name
  //address_prefixes     = [cidrsubnet(var.cidr, 3, 1)]
  address_prefixes                              = [cidrsubnet("10.179.0.0/16", 2, 0)]
  private_link_service_network_policies_enabled = false
  service_endpoints                             = ["Microsoft.Storage"]
  delegation {
    name = "databricks"
    service_delegation {
      name = "Microsoft.Databricks/workspaces"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "private-dummy" {
  subnet_id                 = azurerm_subnet.private-dummy.id
  network_security_group_id = azurerm_network_security_group.dummy.id
}
