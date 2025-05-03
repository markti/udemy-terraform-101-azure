data "azuread_client_config" "current" {}

resource "azuread_group" "remote_access_users" {
  display_name     = "${var.application_name}-${var.environment_name}-remote-access-users"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

locals {
  remote_access_users_map = { for idx, element in var.remote_access_users : element => idx }
}

resource "azuread_group_member" "remote_access_users_membership" {

  for_each = local.remote_access_users_map

  group_object_id  = azuread_group.remote_access_users.object_id
  member_object_id = data.azuread_user.remote_access_users[each.key].object_id

}

data "azuread_user" "remote_access_users" {

  for_each = local.remote_access_users_map

  user_principal_name = each.key

}

resource "azurerm_virtual_machine_extension" "entra_id_login" {
  name                       = "${azurerm_linux_virtual_machine.vm1.name}-AADSSHLogin"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm1.id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "entra_id_user_login" {
  scope                = azurerm_linux_virtual_machine.vm1.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = azuread_group.remote_access_users.object_id
}
