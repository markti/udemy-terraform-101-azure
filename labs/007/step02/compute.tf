locals {
  admin_username = "adminuser"
  computername   = "vm1${var.application_name}${var.environment_name}"
}
resource "azapi_resource" "vm1" {
  type      = "Microsoft.Compute/virtualMachines@2024-07-01"
  name      = local.computername
  location  = azurerm_resource_group.main.location
  parent_id = azurerm_resource_group.main.id

  body = {
    properties = {
      hardwareProfile = {
        vmSize = "Standard_D2_v2_Promo"
      }
      networkProfile = {
        networkInterfaces = [
          {
            id = azapi_resource.vm1_nic.id
          }
        ]
      }
      osProfile = {
        adminUsername = local.admin_username
        computerName  = local.computername
        linuxConfiguration = {
          ssh = {
            publicKeys = [
              {
                keyData = tls_private_key.vm1.public_key_openssh,
                path    = "/home/${local.admin_username}/.ssh/authorized_keys"
              }
            ]
          }
        }
      }
      storageProfile = {
        imageReference = {
          publisher = "Canonical"
          offer     = "0001-com-ubuntu-server-jammy"
          sku       = "22_04-lts"
          version   = "latest"
        }
        osDisk = {
          caching      = "ReadWrite"
          createOption = "FromImage"
          managedDisk = {
            storageAccountType = "Standard_LRS"
          }
        }
      }
    }
  }
}
