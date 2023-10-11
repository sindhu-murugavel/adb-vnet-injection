resource "azurerm_virtual_network" "this" {
  name                = "${local.prefix}-vnet"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = [var.cidr]
  tags                = local.tags
}

resource "azurerm_network_security_group" "this" {
  name                = "${local.prefix}-nsg"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  tags                = local.tags
}

resource "azurerm_subnet" "public" {
  name                 = "public-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  //address_prefixes     = [cidrsubnet(var.cidr, 3, 0)]
  address_prefixes = [cidrsubnet("10.179.0.0/16", 2, 1)]

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

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_subnet" "private" {
  name                 = "private-subnet"
  resource_group_name  = data.azurerm_resource_group.existing_rg.name
  virtual_network_name = azurerm_virtual_network.this.name
  //address_prefixes     = [cidrsubnet(var.cidr, 3, 1)]
  address_prefixes = [cidrsubnet("10.179.0.0/16", 2, 0)]

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

resource "azurerm_subnet_network_security_group_association" "private" {
  subnet_id                 = azurerm_subnet.private.id
  network_security_group_id = azurerm_network_security_group.this.id
}
