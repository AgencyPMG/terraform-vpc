module "public" {
  source = "./public"
  vpc_id = aws_vpc.main.id
  cidr   = var.cidr
  azs    = var.public_subnet_azs
  app    = var.app
  env    = var.env
  igw_id = aws_internet_gateway.main.id
}

