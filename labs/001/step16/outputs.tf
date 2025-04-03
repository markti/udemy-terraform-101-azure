output "application_name" {
  value = var.application_name
}
output "environment_name" {
  value = var.environment_name
}
output "environment_prefix" {
  value = local.environment_prefix
}
output "suffix" {
  value = random_string.suffix.result
}
output "api_key" {
  value     = "${var.api_key}bar"
  sensitive = true
}
output "primary_region" {
  value = var.regions[0]
}
output "primary_region_instance" {
  value = var.region_instance_count[var.regions[0]]
}
output "kind" {
  value = var.sku_settings.kind
}
