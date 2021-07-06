data "azurerm_eventhub_namespace" "example" {
  name                = local.namespace_name
  resource_group_name = var.resource_group_name
}