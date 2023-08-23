terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"

    }
  }
}


provider "azurerm" {
  features {}
}


module "nostra-network"{
    source = "./modules/nostra-azure-standard-networking"

}