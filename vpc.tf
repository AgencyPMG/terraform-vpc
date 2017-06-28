resource "aws_vpc" "main" {
    cidr_block = "${var.cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
        Name = "${var.app}/${var.env} VPC"
        Application = "${var.app}"
        Environment = "${var.env}"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "${var.app}/${var.env} igw"
        Application = "${var.app}"
        Environment = "${var.env}"
    }
}
