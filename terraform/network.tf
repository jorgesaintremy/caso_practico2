#creacion infraestructura de red
resource "azurerm_virtual_network" "vn" {
  name                = "virtual-network-${var.name_suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  # si no se crea la dependencia el despliegue de la vn falla al no encontrar el resource group
  depends_on = [
    azurerm_resource_group.rg
  ]
  tags = {
    environment = "casopractico2"
  }
}

#creacion de subred privada
resource "azurerm_subnet" "sn" {
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.vn
  ]
}

#creacion IP Pública
resource "azurerm_public_ip" "mypublicIp1" {
  name                = "vmpublicip1-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  # si no se crea la dependencia el despliegue de la ip publica falla al no encontrar la vn
  depends_on = [
    azurerm_virtual_network.vn
  ]
  tags = {
    environment = "casopractico2"
  }
}

#creacion NIC
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic-${var.name_suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_public_ip.mypublicIp1
  ]
  ip_configuration {
    name                          = "internal-network"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.mypublicIp1.id
  }

  tags = {
    environment = "casopractico2"
  }
}