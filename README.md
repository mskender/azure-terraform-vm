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

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.nic01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_public_ip.nic01-pub01](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_windows_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocate_public_ip"></a> [allocate\_public\_ip](#input\_allocate\_public\_ip) | Whether to allocate and attach a public IP to the instance. | `bool` | `false` | no |
| <a name="input_caching"></a> [caching](#input\_caching) | Caching strategy for OS disk. | `string` | `"ReadWrite"` | no |
| <a name="input_delete_data_disk_on_termination"></a> [delete\_data\_disk\_on\_termination](#input\_delete\_data\_disk\_on\_termination) | Whether to delete OS disk on termination. Defaults to false. | `string` | `"false"` | no |
| <a name="input_delete_os_disk_on_termination"></a> [delete\_os\_disk\_on\_termination](#input\_delete\_os\_disk\_on\_termination) | Whether to delete OS disk on termination. Defaults to true. | `string` | `"true"` | no |
| <a name="input_location"></a> [location](#input\_location) | Region to deploy VM in. Mandatory. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | VM name. If prefix specified, will prefix it with that value. Mandatory. | `string` | n/a | yes |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids) | An optional list of NSG's to attach to the instance. | `list(string)` | `[]` | no |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | OS boot disk size. If `os_type` is `windows`, this gets set to 127 if less than that value. | `string` | `"30"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Either linux or windows. | `string` | `"linux"` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for `var.username`. If not specified (default), password auth will be disabled (recommended). Mandatory for windows machines. | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for all resources. Optional. | `string` | `""` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP address to assign to machine. If not specified, dynamic assigmnet will be used. | `string` | `""` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key to use for passworless auth. | `string` | `""` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | Resource Group to deploy VM in. Mandatory. | `string` | n/a | yes |
| <a name="input_source_image"></a> [source\_image](#input\_source\_image) | Storage Image reference. If omitted, will use Ubuntu 16/Windows 2016 default images. | `map(string)` | <pre>{<br>  "offer": "",<br>  "publisher": "",<br>  "sku": "",<br>  "version": ""<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for NIC placement. Mandatory | `string` | n/a | yes |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix to use for all resources. Optional. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to all resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | The userland username to login to machine with. | `string` | `"vm-user"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Type of instance to deploy: https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/ or Mandatory. Default is `Standard_B2s`. | `string` | `"Standard_B2s"` | no |

## Outputs

No outputs.
