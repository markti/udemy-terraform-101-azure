variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "api_key" {
  type      = string
  sensitive = true
}
variable "instance_count" {
  type = number
}
variable "enabled" {
  type = bool
}
variable "regions" {
  type = list(string)
}
variable "region_instance_count" {
  type = map(string)
}
variable "region_set" {
  type = set(string)
}
variable "sku_settings" {
  type = object({
    kind = string
    tier = string
  })
}
