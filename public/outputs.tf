output "subnet_ids" {
    value = ["${aws_subnet.public.*.id}"]
}

output "route_table_id" {
    value = "${element(concat(aws_route_table.public.*.id, list("")), 0)}"
}
