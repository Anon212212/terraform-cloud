variable "resource_group_location" {
default     = "North Europe"
description = "Location of the resource group."
}

variable "rg_name" {
type        = string
default     = "CU-AVD-RG"
description = "Name of the Resource group in which to deploy service objects"
}

variable "workspace" {
type        = string
description = "Name of the Azure Virtual Desktop workspace"
default     = "CU-Workspace"
}

variable "hostpool" {
type        = string
description = "Name of the Azure Virtual Desktop host pool"
default     = "CU-FINANCE-HP"
}

variable "rfc3339" {
type        = string
default     = "2023-05-20T12:43:13Z"
description = "Registration token expiration"
}

variable "prefix" {
type        = string
default     = "CU-AVD"
description = "Prefix of the name of the AVD machine(s)"
}
