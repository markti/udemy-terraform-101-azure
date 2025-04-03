resource "random_string" "suffix" {
  length = 6
}

locals {
  environment_prefix = "${var.application_name}-${var.environment_name}"
}
