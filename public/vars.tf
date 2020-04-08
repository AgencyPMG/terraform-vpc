variable "azs" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "cidr_offset" {
  default = 0
}

variable "app" {
  type = string
}

variable "env" {
  type = string
}

variable "cidr" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "name_suffix" {
  type    = string
  default = "public"
}

variable "public_on_launch" {
  default = false
}

