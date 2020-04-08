resource "aws_subnet" "internal" {
  count                   = length(var.internal_subnet_azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr, 8, 150 + count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.internal_subnet_azs, count.index)
  tags = {
    Name        = "${var.app}/${var.env} internal (${element(var.internal_subnet_azs, count.index)})"
    Application = var.app
    Environment = var.env
  }
}

resource "aws_route_table" "internal" {
  count  = length(var.internal_subnet_azs) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.app}/${var.env} internal rt"
    Application = var.app
    Environment = var.env
  }
}

resource "aws_route_table_association" "internal" {
  count          = length(var.internal_subnet_azs)
  subnet_id      = element(aws_subnet.internal.*.id, count.index)
  route_table_id = aws_route_table.internal[0].id
}

