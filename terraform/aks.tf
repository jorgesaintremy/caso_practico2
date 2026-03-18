resource "azurerm_kubernetes_cluster" "aks" {
  name                = "kubernetesclusterCP2${var.name_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns_prefix          = "saintremycasopractico2"
  sku_tier = "Standard"
  depends_on = [ azurerm_resource_group.rg ]
 

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2als_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "casopractico2"
  }
}

resource "azurerm_role_assignment" "ra_pull" {
  principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope = azurerm_container_registry.acr.id
  depends_on = [ azurerm_kubernetes_cluster.aks, azurerm_container_registry.acr ]
}