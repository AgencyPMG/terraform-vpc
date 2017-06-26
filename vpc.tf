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
