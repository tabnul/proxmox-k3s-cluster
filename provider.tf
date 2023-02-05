terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.0"
    }
    phpipam = {
      source = "lord-kyron/phpipam"
      version = "1.2.8"
    }
    aws = {
      source = "hashicorp/aws"
      version = "3.7.0"
    }
  }
}



provider "phpipam" {
  app_id   = var.phpipam_appid
  endpoint = var.phpipam_url
  password = var.phpipam_password
  username = var.phpipam_username
  insecure = true
}


provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = "/root/.aws/credentials"
  profile = "terraform"
}


provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = var.pm_api_url
    pm_password = var.pm_password
    pm_user = var.pm_user
}
