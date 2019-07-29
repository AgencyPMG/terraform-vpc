output "vpc_id" {
    value = "${aws_vpc.main.id}"
}

output "public_subnet_ids" {
    value = ["${module.public.subnet_ids}"]
}

output "public_subnet_arns" {
    value = ["${module.public.subnet_arns}"]
}

output "public_route_table_id" {
    value = "${module.public.route_table_id}"
}

output "private_subnet_ids" {
    value = ["${aws_subnet.private.*.id}"]
}

output "private_subnet_arns" {
    value = ["${aws_subnet.private.*.arn}"]
}

output "private_route_table_ids" {
    value = ["${aws_route_table.private.*.id}"]
}

output "private_nat_ips" {
    value = ["${aws_eip.nat.*.public_ip}"]
}

output "internal_subnet_ids" {
    value = ["${aws_subnet.internal.*.id}"]
}

output "internal_subnet_arns" {
    value = ["${aws_subnet.internal.*.arn}"]
}

output "internal_route_table_id" {
    value = "${element(concat(aws_route_table.internal.*.id, list("")), 0)}"
}

output "dns_zone_id" {
    value = "${aws_route53_zone.main.zone_id}"
}

output "dns_zone_name" {
    value = "${aws_route53_zone.main.name}"
}
