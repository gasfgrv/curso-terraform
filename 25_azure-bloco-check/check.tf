check "nsg_rules" {
  data "azurerm_network_security_group" "rules" {
    name                = azurerm_network_security_group.network_security_group.name
    resource_group_name = azurerm_resource_group.resource_group.name
  }

  assert {
    condition     = sort([for rule in data.azurerm_network_security_group.rule : rule.destination_port_range]) == sort(local.nsg_ports)
    error_message = "Regras não condizem com o que foi configurado"
  }
}