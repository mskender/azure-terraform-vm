resource "azurerm_windows_virtual_machine" "vm" {
  count = lower(var.os_type) == "windows" ? 1:0
  name                  = local.vm_name
  location              = var.location
  resource_group_name   = var.rg_name

  size               = var.vm_size
  admin_username    = var.username
  admin_password = var.password

  network_interface_ids = [
      azurerm_network_interface.nic01.id
    ]

  dynamic "source_image_reference" {
    for_each =  [ local.source_image ]
    content {
      publisher = source_image_reference.value["publisher"]
      offer = source_image_reference.value["offer"]
      sku = source_image_reference.value["sku"]
      version = source_image_reference.value["version"]

    }
 }

  os_disk {
    name              = "${local.vm_name}-os-disk"
    caching           = var.caching
    disk_size_gb = tonumber(var.os_disk_size) < 127 ? "127" : var.os_disk_size
    storage_account_type = "Standard_LRS"
  }

  tags = var.tags
}