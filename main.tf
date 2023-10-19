# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = ">=1.13.0"
    }
  }
}

resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}


data "azurerm_resource_group" "existing_rg" {
  name = "sindhu-wegmans-uc"
  }


locals {

  prefix = "wegmans"
  location = var.location
  dbfsname = join("", [var.dbfs_prefix, "${random_string.naming.result}"]) // dbfs name must not have special chars


  // tags that are propagated down to all resources
  tags = {
    Environment = "Testing"
    Epoch       = random_string.naming.result
    RemoveAfter = "2024-01-31"
    Owner       = "sindhu.murugavel@databricks.com"
  }
}
