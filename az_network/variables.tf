
variable "virtual_network_name" {
  type        = string
  description = "virtual network name"
}

variable "resource_group_name" {
  type        = string
  description = "provide the name for the resource group"
}
variable "location" {
  type        = string
  description = "provide the location name where exactly resource need to be created"
}

variable "address_space" {
  type        = list(string)
  description = "provide cidr address for network creation"
}

variable "subnet_name" {
  type        = string
  description = "provide the subnet name"
}

variable "subnet_prefix_count" {
  type        = list(string)
  description = "provide the subnet address prefix count"
}