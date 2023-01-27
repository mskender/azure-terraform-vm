# Simple VM module for Azure


## Description

This is a module to provide a simple way to create your VM's (Linux or Windows).
It is not exhaustive in its options - in which case it's simpler to just use TF resource than a module.

You can specify:
- Machine OS type (linux or windows, as of azurerm v2 provider these use 2 separate resources)
- Instance size, disk size
- Create static/dynamic NIC
- Create and attach a public IP
- If no source image is specified, defaults are used (Win 2016/Ubuntu 16 LTS)
- Can provide a list on NSG's to attach to NIC
- Tags all resources with `var.tags` as well as adding os type, flavor and version tags.


## Examples

Allways pin the module version with tag! The examples omit this simplify this README maintenance or cargo-culting mistakes.

```
module "nix01" {
    source = "github.com/mskender/azure-terraform-vm"

    prefix = "test"
    name="nix01"
    location = "West Europe"
    rg_name = "my_rg"
    subnet_id = azurerm_subnet.example.id
    source_image = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "16.04-LTS"
            version   = "latest"
        }
    }
    public_key = file("~/.ssh/id_rsa.pub")
```

```
module "doze01" {
    source = "github.com/mskender/azure-terraform-vm"

    os_type = "Windows"
    prefix = "test"
    name="win01"
    password = "You_should_not_have_this_in_code!!!"
    location = "West Europe"
    rg_name = "my_rg"
    subnet_id = azurerm_subnet.example.id
    private_ip = "10.0.10.10"
}
```
