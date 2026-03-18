#Security group para el acceso por SSH a la VM
resource "azurerm_network_security_group" "mySecurityGroup" {
  name                = "sshtraffic-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg, azurerm_network_interface.nic
  ]


  security_rule {
    name                       = "ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Acceso web por el puerto 80
    security_rule {
    name                       = "http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "casopractico2"
  }
}

#Security Group -> NIC de la VM
resource "azurerm_network_interface_security_group_association" "mySecurityGroupAssociation1" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.mySecurityGroup.id


}