data "aws_region" "current" {
    current = true
}

resource "aws_vpc_endpoint" "s3" {
    vpc_id = "${aws_vpc.main.id}"
    service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "public" {
    count = "${length(var.public_subnet_azs) > 0 ? 1 : 0}"
    vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
    route_table_id = "${module.public.route_table_id}"
}

resource "aws_vpc_endpoint_route_table_association" "private" {
    count = "${length(var.private_subnet_azs)}"
    vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
    route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_vpc_endpoint_route_table_association" "internal" {
    count = "${length(var.internal_subnet_azs) > 0 ? 1 : 0}"
    vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
    route_table_id = "${aws_route_table.internal.id}"
}
