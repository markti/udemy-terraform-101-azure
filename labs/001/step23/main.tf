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

module "alpha" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "bravo" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}


module "charlie" {
  source = "./modules/rando"
  length = 8
}

locals {
  regional_stamps = {
    "foo" = {
      region         = "westus"
      min_node_count = 4
      max_node_count = 8
    },
    "bar" = {
      region         = "eastus"
      min_node_count = 4
      max_node_count = 8
    }
  }
}

module "regional_stamps" {

  source = "./modules/regional-stamp"

  for_each = local.regional_stamps

  region         = each.value.region
  name           = each.key
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count

}
