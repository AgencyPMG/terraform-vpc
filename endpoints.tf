data "aws_region" "current" {}

# s3 vpc endpoint and routes
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.main.id}"
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "public-s3" {
  count           = "${length(var.public_subnet_azs) > 0 ? 1 : 0}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${module.public.route_table_id}"
}

resource "aws_vpc_endpoint_route_table_association" "private-s3" {
  count           = "${length(var.private_subnet_azs)}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "internal-s3" {
  count           = "${length(var.internal_subnet_azs) > 0 ? 1 : 0}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
  route_table_id  = "${aws_route_table.internal.id}"
}

# ecr vpc endpoints
resource "aws_security_group" "vpc-endpoints" {
  name        = "vpc-endpoints@${var.app}${var.env}"
  description = "allow access to vpc-endpoints for ${var.app} ${var.env}"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr}"]
  }
}

data "aws_vpc_endpoint_service" "ecr-api" {
  service = "ecr.api"
}

resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "${data.aws_vpc_endpoint_service.ecr-api.service_name}"
  vpc_endpoint_type = "Interface"

  subnet_ids          = ["${aws_subnet.private.*.id}"]
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.vpc-endpoints.id}",
  ]
}

data "aws_vpc_endpoint_service" "ecr-dkr" {
  service = "ecr.dkr"
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "${data.aws_vpc_endpoint_service.ecr-dkr.service_name}"
  vpc_endpoint_type = "Interface"

  subnet_ids          = ["${aws_subnet.private.*.id}"]
  private_dns_enabled = true

  security_group_ids = [
    "${aws_security_group.vpc-endpoints.id}",
  ]
}
