
resource "azurerm_virtual_network" "prodnetwork" {
  name                = var.vnet_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space 

  
 #  depends_on = [
  #   azurerm_resource_group.appgrp
 #  ]
  }


  resource "azurerm_subnet" "subnets" {
  count=var.number_of_subnets
  name                 = "${var.prefix}-LAN-${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.resource_group_location
  address_prefixes     = ["10.0.${count.index}.0/24"]
  depends_on = [
    azurerm_virtual_network.prodnetwork
  ]
}



resource "azurerm_subnet" "vpngwsub" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.resource_group_location
  address_prefixes     = var.gw_sub_address

  depends_on = [ azurerm_virtual_network.prodnetwork ]

}

resource "azurerm_public_ip" "vpngepip" {
  name                =  var.vpn_public_ip
  location            =  var.resource_group_location
  resource_group_name =  var.resource_group_name

  allocation_method = "Dynamic"
  
}


resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = var.vpn_gateway_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngepip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpngwsub.id
  }

}

resource "azurerm_network_security_group" "appnsg" {
  
  name                = "${var.prefix}-PROD-NSG"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowPing"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  
}

resource "azurerm_subnet_network_security_group_association" "appnsglink" {
  count=var.number_of_subnets
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.appnsg.id
  depends_on = [
    azurerm_virtual_network.prodnetwork,
    azurerm_network_security_group.appnsg
  ]
}

