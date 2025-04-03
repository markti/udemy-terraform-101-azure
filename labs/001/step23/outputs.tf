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
output "alpha" {
  value = module.alpha.random_string
}
output "bravo" {
  value = module.bravo.random_string
}
output "charlie" {
  value = module.charlie.random_string
}
output "regionA" {
  value = module.regional_stamps[0].name
}
output "regionA" {
  value = module.regional_stamps[1].name
}
