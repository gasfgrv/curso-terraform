locals {
  common_tags = {
    owner      = "gasfgrv"
    managed-by = "terraform"
  }

  nsg_ports = [
    "80",
    "443",
    "8080"
  ]
}