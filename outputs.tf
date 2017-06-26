output "vpc_id" {
    value = "${aws_vpc.main.id}"
}

output "public_subnet_ids" {
    value = ["${module.public.subnet_ids}"]
}

output "public_route_table_id" {
    value = "${module.public.route_table_id}"
}

output "private_subnet_ids" {
    value = ["${aws_subnet.private.*.id}"]
}

output "private_route_table_ids" {
    value = ["${aws_route_table.private.*.id}"]
}

output "internal_subnet_ids" {
    value = ["${aws_subnet.internal.*.id}"]
}

output "internal_route_table_id" {
    value = "${aws_route_table.internal.id}"
}

output "dns_zone_id" {
    value = "${aws_route53_zone.main.zone_id}"
}
