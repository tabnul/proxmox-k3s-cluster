data "phpipam_subnet" "subnet" {
  subnet_address = var.phpipam_subnet_adress
  subnet_mask    = var.phpipam_subnet_mask
}
