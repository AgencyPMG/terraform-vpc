variable "app" {
  type        = string
  description = "The application name, used in the `Application` tags."
}

variable "env" {
  type        = string
  description = "The application environment (prod, staging, etc). Pass in terraform.env here if you like. Used in the `Environment` tags."
}

variable "cidr" {
  type        = string
  description = "The VPC cidr block you desire."
  default     = "10.0.0.0/16"
}

variable "dns_name" {
  type        = string
  description = "The `name` to be used with the route53 internal zone on the VPC. Defaults to {var.app}{var.env}.internal"
}

variable "public_subnet_azs" {
  type        = list(string)
  description = "A list of availability zones in which public subnets will be placed."
}

variable "private_subnet_azs" {
  type        = list(string)
  description = "A list of availability zones in which private subnets will be placed."
}

variable "internal_subnet_azs" {
  type        = list(string)
  description = "A list of availability zones in which internal subnets will be placed."
}

