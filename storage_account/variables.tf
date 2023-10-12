
variable "resource_name" {
  type        = string
  description = "provide the name for the storage account"
}
variable "location" {
  type        = string
  description = "provide the location name where exactly resource need to be created"
}
variable "resource_group_name" {
  type        = string
  description = "provide the resourcegroup name which will store storage resource inside the rsg"
}

variable "account_tier" {
  type        = string
  description = "provide the account tier which type Standard or Premium or Any"
  validation {
    condition     = (contains(["Standard", "Premium"], var.account_tier))
    error_message = "Account Tier values must be 'Standard'or 'Premium' "
  }
}

variable "account_replication_type" {
  type        = string
  description = "provide the Replication Type  which type LRS or GRS or Any"
  validation {
    condition     = (contains(["LRS", "GRS"], var.account_replication_type))
    error_message = "Replication must be 'LRS or GRS'"
  }

}