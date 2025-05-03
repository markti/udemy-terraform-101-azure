resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2021-04-01"
  name      = "rg-${var.application_name}-${var.environment_name}"
  location  = var.primary_location
  parent_id = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
}
data "azapi_client_config" "current" {}

# main 7
# nic 46
# pip 16
# kv 50
# vm 50

# TOTAL 169
