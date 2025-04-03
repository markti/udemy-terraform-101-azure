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
