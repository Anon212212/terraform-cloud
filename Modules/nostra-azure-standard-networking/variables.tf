variable "prefix" {
    description = "customer prefix"
    default = "CG"
}
variable "location" {
  description = "(Required) location where this resource has to be created"
  default = "northeurope"
}

variable "vnet_name" {
  type        = string
  default     = "CG-AZ-VNET"
  description = "Name of the vnet to create."
}

variable "vnet_address_space" {
  type        = list
  default =["10.145.0.0/16"]
  description = "The address space that is used by the virtual network."
}



variable "number_of_subnets" {
  type=number
  description="This defines the number of subnets"
  default =2
  validation {
    condition = var.number_of_subnets < 5
    error_message = "The number of subnets must be less than 5."
  }
}
variable "gw_sub_address" {
  type        = list(string)
  default     = ["10.145.254.0/24"]

}

#--VPN Connection
variable "vpn_public_ip" {
    type        = string
    default     = "az_vpn_ip"
    description = "VPN Public IP"
}
#--Peer VPN Gateway
variable "peer_vpn_gateway" {
    description = "Peer VPN Gateway"
    type        = string
    default     = "main_office_vpn_gateway"
}

#--Peer VPN Gateway
variable "customer_gw_address" {
    type        = string
    default     = "89.10.196.22"
}

#--Subnet Address Spaces
variable "peer_subnet_address_spaces" {
    description = "All peer subnets"
    type        = list(string)
    default     = ["172.16.1.0/24",]
}

#--VPN Connection name
variable "vpn_connection" {
    description = "VPN Connection Head Office"
    type        = string
    default     = "S2S_vpn_connection"
}

#--VPN Connection name
variable "vpn_psk" {
    description = "VPN Connection Head Office"
    type        = string
    default     = "123456789"

}

#--VPN Gateway
variable "vpn_gateway_name" {
    description = "VPN Gateway"
    type        = string
    default     = "headoffice_vpn_gateway"
}




variable "resource_group_location" {
  type        = string
  default     = "North Europe"
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}


variable "resource_group_name" {
  type        = string
  default="RG-CG-PROD"
  description = "The name of an existing resource group to be imported."
}
