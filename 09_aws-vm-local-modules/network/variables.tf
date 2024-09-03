variable "cidr_vpc" {
  description = "Cidr para VPC criada na AWS"
  type        = string
}

variable "cidr_subnet" {
  description = "Cidr para subnet criada na AWS"
  type        = string
}

variable "environment" {
  description = "Ambiente onde se encontram os recursos"
  type        = string
}
