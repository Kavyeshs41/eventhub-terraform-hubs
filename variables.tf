variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "eventhub_namespaces_hubs" {
  type        = any
  description = "Map to handle Eventhub creation. It supports the creation of the hubs, authorization_rule associated with each namespace you create"
}
