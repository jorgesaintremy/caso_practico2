# Resource group
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

# VM
output "azurerm_network_interface_nic_id" {
  value = azurerm_network_interface.nic.id
}

output "public_ip_address" {
  value = azurerm_public_ip.mypublicIp1.ip_address
  description = "VM Public IP"
}

output "public_ip_address_id" {
  value = azurerm_public_ip.mypublicIp1.id
}

output "ssh_public_key_openssh" {
  value = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}

output "ssh_private_key_pem" {
  value = tls_private_key.ssh_key.private_key_pem
  sensitive = true
}

# AKS
output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_kubeconfig" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_host" {
  value = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

# ACR
output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_hostname" {
  value = "${azurerm_container_registry.acr.name}.azurecr.io"
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}

output "acr_login_url" {
  value = azurerm_container_registry.acr.login_server
}