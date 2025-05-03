resource "tls_private_key" "vm1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "azapi_resource" "devops_rg" {
  name      = "rg-devops-dev"
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  type      = "Microsoft.Resources/resourceGroups@2021-04-01"
}

data "azapi_resource" "keyvault" {
  name      = "kv-devops-dev-28482i"
  parent_id = data.azapi_resource.devops_rg.id
  type      = "Microsoft.KeyVault/vaults@2024-12-01-preview"
}

resource "azapi_resource" "vm_ssh_private" {
  name                      = "azapivm-ssh-private"
  parent_id                 = data.azapi_resource.keyvault.id
  type                      = "Microsoft.KeyVault/vaults/secrets@2024-12-01-preview"
  schema_validation_enabled = false

  body = {
    properties = {
      value = tls_private_key.vm1.private_key_pem
    }
  }

  lifecycle {
    ignore_changes = [
      location
    ]
  }
}

resource "azapi_resource" "vm_ssh_public" {
  name                      = "azapivm-ssh-public"
  parent_id                 = data.azapi_resource.keyvault.id
  type                      = "Microsoft.KeyVault/vaults/secrets@2024-12-01-preview"
  schema_validation_enabled = false

  body = {
    properties = {
      value = tls_private_key.vm1.public_key_openssh
    }
  }

  lifecycle {
    ignore_changes = [
      location
    ]
  }
}
