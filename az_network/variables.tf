
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


//pip vars

variable "public_ip_name" {
  type        = string
  description = "provide the public ip name"
}

#nic
variable "network_interface_name" {
  type        = string
  description = "provide the public nic name"
}

//nsg

variable "network_security_group_name" {
  type = string
  description = "provide network securitygroup name"
}

variable "nsg_security_rule" {
  type = string
  description = "provide network security rules"
  default = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

//keyvault
variable "key_vault_name" {
  type = string
}
variable "key_permissions" {
  type = list(string)
  description = "provide key permissions for kv"
}
variable "secret_permissions" {
  type = list(string)
  description = "provide secret permissions for kv if don't want provide variables as []"
}
variable "storage_permissions" {
  type = list(string)
  description = "provide storage permissions for kv  if don't want provide variables as []"
}
variable "certificate_permissions" {
  type = list(string)
  description = "provide certificate permissions for kv  if don't want provide variables as []" 
}

//vm
variable "admin_username" {
  type = string
  description = "provide admin username"
}
variable "virtual_machine_name" {
  type = string
  description = "provide virtual machine name"
}
variable "vm_size" {
  type = string
  description = "provide virtual machine"
}
variable "managed_disk_type" {
  type = string
  description = "provide managed disk type"
}

variable "ssh_secret_name" {
  type = string
  description = "provide the secret name for sshkey"
}
variable "os_disk_name" {
    type = string
    description = "provide name for os_disk_name"
}
