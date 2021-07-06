resource "azurerm_eventhub_namespace_authorization_rule" "reader" {
  for_each            = toset(local.namespaces_reader)
  name                = "${each.key}-reader"
  namespace_name      = local.namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "sender" {
  for_each            = toset(local.namespaces_sender)
  name                = "${each.key}-sender"
  namespace_name      = local.namespace_name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "manage" {
  for_each            = toset(local.namespaces_manage)
  name                = "${each.key}-manage"
  namespace_name      = local.namespace_name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}
