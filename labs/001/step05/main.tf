resource "random_string" "suffix" {
  length = 6
}

locals {
  environment_prefix = "marksblog-dev"
}
