resource "azurerm_eventhub" "eventhub" {
  for_each            = toset(local.hubs_list)
  name                = split("|", each.key)[1]
  resource_group_name = var.resource_group_name
  namespace_name      = local.namespace_name

  message_retention = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "message_retention", 1)
  partition_count   = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "partition_count", 1)

  capture_description {
    enabled             = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_enabled", false)
    encoding            = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_encoding", "Avro")
    interval_in_seconds = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_interval_seconds", 60)
    size_limit_in_bytes = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_size_limit_bytes", 10485760)
    skip_empty_archives = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_skip_empty_archives", true)
    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_dst_format", "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}")
      blob_container_name = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_blob_name", "eventhub")
      storage_account_id  = lookup(var.eventhub_namespaces_hubs[split("|", each.key)[0]]["hubs"][split("|", each.key)[1]], "capture_storage_acc_id")
    }
  }
}
