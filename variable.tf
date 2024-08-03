variable "environment" {
  description = "Environment variable prefix"
  type        = string
  default     = "poc"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "lara_rg"
}

variable "location" {
  description = "Loction where resources will be deployed"
  type        = string
  default     = "UK South"
}

variable "resource_owner" {
  description = "Resource owner name"
  type        = string
  default     = "lara"
}
variable "location_prefix" {
  description = "Resource location identifier"
  type        = string
  default     = "uks"
}