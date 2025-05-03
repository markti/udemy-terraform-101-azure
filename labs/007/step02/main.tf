resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

# main 4
# nic 31
# pip 16
# kv 21
# vm 54

# TOTAL 169
# NEW TOTAL: 126
