/*resource "azurerm_resource_group" "existing_rg"{
  name = "sindhu-wegmans-uc"
  location = var.location
}*/

data "azurerm_resource_group" "other_rg" {
  name = "sindhu_overwatch_test"
}

resource "azurerm_databricks_workspace" "dummy" {
  name                = "${local.prefix}-testworkspace"
  resource_group_name = data.azurerm_resource_group.other_rg.name
  location            = var.location
  sku                 = "premium"
  tags                = local.tags

  custom_parameters {
    no_public_ip                                         = var.no_public_ip
    virtual_network_id                                   = azurerm_virtual_network.dummy.id
    private_subnet_name                                  = azurerm_subnet.private-dummy.name
    public_subnet_name                                   = azurerm_subnet.public-dummy.name
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public-dummy.id
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private-dummy.id
    storage_account_name                                 = "dbfs1soqsg2"
  }

  # We need this, otherwise destroy doesn't cleanup things correctly
  depends_on = [
    azurerm_subnet_network_security_group_association.public-dummy,
    azurerm_subnet_network_security_group_association.private-dummy
  ]
}

