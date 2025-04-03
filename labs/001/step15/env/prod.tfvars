environment_name = "prod"
instance_count   = 4
enabled          = false
regions          = ["westus", "eastus", "westus"]
region_instance_count = {
  "westus" = 4
  "eastus" = 8
}
region_set = ["westus", "eastus"]
sku_settings = {
  kind = "P"
  tier = "Business"
}
