resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

# main 4
# nic 17
# pip 7
# kv 21
# vm 33

# TOTAL 82
