# creacion azure container registry
resource "azurerm_container_registry" "acr" {
  name                = "containerRegistryCP2${var.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    environment = "casopractico2"
  }
}