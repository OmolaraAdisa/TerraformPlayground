variable "environment" {
  description = "Environment variable prefix"
  type        = string
}

variable "location" {
  description = "Loction where resources will be deployed"
  type        = string
}

variable "resource_owner" {
  description = "Resource owner name"
  type        = string
}

variable "location_prefix" {
  description = "Resource location identifier"
  type        = string
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_address" {
  description = "Web subnet address space"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_address" {
  description = "Application subnet address space"
  type        = list(string)
  default     = ["10.0.11.0/24"]
}

variable "db_subnet_address" {
  description = "Database subnet address space"
  type        = list(string)
  default     = ["10.0.21.0/24"]
}

variable "bastion_subnet_address" {
  description = "Bastion subnet address space"
  type        = list(string)
  default     = ["10.0.100.0/24"]
}