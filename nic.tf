resource "azurerm_network_interface" "nic01" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${local.nic_name}-c01"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip == "" ? "Dynamic" : "Static"
    private_ip_address = var.private_ip
    public_ip_address_id = var.allocate_public_ip ? azurerm_public_ip.nic01-pub01[0].id : ""
  }
  tags = var.tags
}

resource "azurerm_public_ip" "nic01-pub01" {
  count = var.allocate_public_ip ? 1:0
  name                = "${local.nic_name}-pub01"
  resource_group_name = var.rg_name
  location            = var.location
  sku = "Standard"
  allocation_method   = "Static" #Static - allocated upon PubIP creation. Dynamic - allocated upon NIC attachment, released when attachment deleted.
  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nic01" {
  count = length(var.nsg_ids)
  network_interface_id      = azurerm_network_interface.nic01.id
  network_security_group_id = var.nsg_ids[count.index]
}