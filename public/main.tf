resource "aws_subnet" "public" {
    count = "${length(var.azs)}"
    vpc_id = "${var.vpc_id}"
    cidr_block = "${cidrsubnet(var.cidr, 8, var.cidr_offset + count.index)}"
    map_public_ip_on_launch = "${var.public_on_launch}"
    assign_ipv6_address_on_creation = "${var.public_on_launch}"
    availability_zone = "${element(var.azs, count.index)}"
    tags {
        Name = "${var.app}/${var.env} ${var.name_suffix} (${element(var.azs, count.index)})"
        Application = "${var.app}"
        Environment = "${var.env}"
    }
}

resource "aws_route_table" "public" {
    count = "${length(var.azs) > 0 ? 1 : 0}"
    vpc_id = "${var.vpc_id}"
    tags {
        Name = "${var.app}/${var.env} ${var.name_suffix}"
        Application = "${var.app}"
        Environment = "${var.env}"
    }
}

resource "aws_route" "public" {
    count = "${length(var.azs) > 0 ? 1 : 0}"
    route_table_id = "${aws_route_table.public.id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igw_id}"
}

resource "aws_route_table_association" "public" {
    count = "${length(var.azs)}"
    subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public.id}"
}
