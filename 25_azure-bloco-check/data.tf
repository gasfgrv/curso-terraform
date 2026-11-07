data "azurerm_network_security_group" "nsg" {
  depends_on          = [azurerm_network_security_group.network_security_group]
  name                = azurerm_network_security_group.network_security_group.name
  resource_group_name = azurerm_resource_group.resource_group.name
}