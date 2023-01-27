locals {
    prefix = var.prefix == "" ? "" : "${var.prefix}-"
    suffix = var.suffix == "" ? "": "-${var.suffix}"
    vm_name = "${local.prefix}${var.name}${local.suffix}"
    nic_name = "${local.vm_name}-nic01"


    default_source_images =  {
        linux = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "16.04-LTS"
            version   = "latest"
        }
        windows = {
            publisher = "MicrosoftWindowsServer"
            offer     = "WindowsServer"
            sku       = "2016-Datacenter"
            version   = "latest"
        }
    }

    source_image = (  var.source_image["offer"] == "" ||
                      var.source_image["publisher"] == "" )  ? local.default_source_images[lower(var.os_type)]  :  var.source_image

    tags = merge (
        {
            "os_type" = lower(var.os_type)
            "os_flavor" =  local.source_image["offer"]
            "os_version" = local.source_image["sku"]
        },
        var.tags
    )
}