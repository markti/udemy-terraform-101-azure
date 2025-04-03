resource "random_string" "suffix" {
  length = 6
}

locals {
  environment_prefix = "${var.application_name}-${var.environment_name}-${random_string.suffix.result}"
}

resource "random_string" "list" {

  count = length(var.regions)

  length  = 6
  upper   = false
  special = false

}

resource "random_string" "map" {

  for_each = var.region_instance_count

  length  = 6
  upper   = false
  special = false

}


resource "random_string" "if" {

  count = var.enabled ? 1 : 0

  length  = 6
  upper   = false
  special = false

}
