resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr, 8, 50 + count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.private_subnet_azs, count.index)
  tags = {
    Name        = "${var.app}/${var.env} private (${element(var.private_subnet_azs, count.index)})"
    Application = var.app
    Environment = var.env
  }
}

module "private_nats" {
  source           = "./public"
  vpc_id           = aws_vpc.main.id
  cidr             = var.cidr
  cidr_offset      = 100
  azs              = [var.private_subnet_azs]
  app              = var.app
  env              = var.env
  igw_id           = aws_internet_gateway.main.id
  name_suffix      = "private nat"
  public_on_launch = false
}

resource "aws_eip" "nat" {
  count = length(var.private_subnet_azs)
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.private_subnet_azs)
  subnet_id     = element(module.private_nats.subnet_ids, count.index)
  allocation_id = element(aws_eip.nat.*.id, count.index)
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnet_azs)
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.app}/${var.env} private rt (${element(var.private_subnet_azs, count.index)})"
    Application = var.app
    Environment = var.env
  }
}

resource "aws_route" "private_nat" {
  count                  = length(var.private_subnet_azs)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_azs)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

