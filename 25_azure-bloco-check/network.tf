resource "azurerm_resource_group" "resource_group" {
  name     = "rg-check"
  location = "West Europe"
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "nsg-check"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_network_security_rule" "rule" {
  for_each                    = toset(local.nsg_ports)
  name                        = "port-${each.key}"
  priority                    = index(local.nsg_ports, each.key) * 10 + 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.key
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}