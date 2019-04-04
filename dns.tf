resource "aws_route53_zone" "main" {
    name = "${var.dns_name}"
    vpc {
        vpc_id = "${aws_vpc.main.id}"
    }
    comment = "${var.app}/${var.env} internal dns zone"
    tags {
        Name = "${var.app}/${var.env} internal dns"
        Application = "${var.app}"
        Environment = "${var.env}"
    }
}
