locals {

}

resource "azurerm_linux_virtual_machine" "vm" {
  count = lower(var.os_type) == "linux" ? 1:0
  name                  = local.vm_name
  location              = var.location
  resource_group_name   = var.rg_name

  size               = var.vm_size
  admin_username    = var.username
  admin_password = var.password
  disable_password_authentication = var.password == "" ? true : false
  network_interface_ids = [
      azurerm_network_interface.nic01.id
    ]



   #delete_os_disk_on_termination = var.delete_os_disk_on_termination
   #delete_data_disks_on_termination = var.delete_os_disk_on_termination

  dynamic "source_image_reference" {
    for_each = [ local.source_image ]
    content {
      publisher = source_image_reference.value["publisher"]
      offer = source_image_reference.value["offer"]
      sku = source_image_reference.value["sku"]
      version = source_image_reference.value["version"]

    }
 }

  dynamic "admin_ssh_key" {
        for_each = var.public_key != "" ? [0]:[]
      content {
        username = var.username
        public_key = var.public_key
      }
  }

  os_disk {
    name              = "${local.vm_name}-os-disk"
    caching           = var.caching
    disk_size_gb = var.os_disk_size
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}
