output "subnet_ids" {
    value = ["${aws_subnet.public.*.id}"]
}

output "route_table_id" {
    value = ["${aws_route_table.public.*.id}"]
}
