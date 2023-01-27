variable "os_type" {
  description =  "Either linux or windows."
  type=string
  default = "linux"
}

variable "name" {
    description = "VM name. If prefix specified, will prefix it with that value. Mandatory."
    type = string
}

variable "prefix" {
  description = "Prefix to use for all resources. Optional."
  type = string
  default = ""
}

variable "suffix" {
  description = "Suffix to use for all resources. Optional."
  type = string
  default = ""
}

variable "location" {
  description = "Region to deploy VM in. Mandatory."
  type = string
}

variable "rg_name" {
  description = "Resource Group to deploy VM in. Mandatory."
  type = string
}

variable "vm_size" {
  description = "Type of instance to deploy: https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/ or Mandatory. Default is `Standard_B2s`. "
  type = string
  default = "Standard_B2s"
}

variable "delete_os_disk_on_termination" {
  description = "Whether to delete OS disk on termination. Defaults to true."
  type = string
  default = "true"
}

variable "delete_data_disk_on_termination" {
  description = "Whether to delete OS disk on termination. Defaults to false."
  type = string
  default = "false"
}


variable "username" {
  description = "The userland username to login to machine with."
  type = string
  default = "vm-user"
}

variable "password" {
  description = "Password for `var.username`. If not specified (default), password auth will be disabled (recommended). Mandatory for windows machines."
  type = string
  default = ""
}

variable "caching" {
  description = "Caching strategy for OS disk."
  type = string
  default = "ReadWrite"
}

variable "os_disk_size" {
  description = "OS boot disk size. If `os_type` is `windows`, this gets set to 127 if less than that value."
  type = string
  default = "30"
}

variable source_image {
  description = "Storage Image reference."
  type = map(string)
  default ={
    publisher = ""
    offer     = ""
    sku       = ""
    version   = ""
  }
}

variable "subnet_id" {
  description = "Subnet ID for NIC placement. Mandatory"
  type = string
}

variable "tags" {
  description = "A map of tags to assign to all resources created by this module."
  type = map(string)
  default = {}
}

variable "nsg_ids" {
  description = "An optional list of NSG's to attach to the instance."
  type = list(string)
  default = [ ]
}

variable "allocate_public_ip" {
  description = "Whether to allocate and attach a public IP to the instance."
  type = bool
  default = false
}

variable "private_ip" {
  description = "Private IP address to assign to machine. If not specified, dynamic assigmnet will be used."
  type = string
  default = ""
}

variable "public_key" {
  description = "Public key to use for passworless auth."
  type = string
  sensitive = true
  default = ""
}