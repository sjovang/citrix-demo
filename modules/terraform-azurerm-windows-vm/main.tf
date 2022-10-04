terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 3.0.0"
        }
        random = {
            source = "hashicorp/random"
            version = ">= 3.0.0"
        }
    }
}

resource "random_password" "local_administrator_password" {
    length = 32
}