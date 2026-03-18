variable "resource_group_name" {
  type        = string
  default     = "rg-casopractico2"
  description = "Resource Group Azure Name"
}

variable "location_name" {
  type        = string
  default     = "Sweden Central"
  description = "Azure Location Name"
}

variable "name_suffix" {
  type = string
  default = "saintremy"
}