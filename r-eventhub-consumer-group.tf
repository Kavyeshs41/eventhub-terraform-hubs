resource "azurerm_eventhub_consumer_group" "eventhub_consumer_group" {
  for_each            = toset(local.hubs_list)
  name                = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "consumer_group", "default")
  namespace_name      = local.namespace_name
  eventhub_name       = split("|", each.key)[1]
  resource_group_name = var.resource_group_name

  depends_on = [
    azurerm_eventhub.eventhub
  ]
}