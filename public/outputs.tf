output "subnet_ids" {
  value = [aws_subnet.public.*.id]
}

output "subnet_arns" {
  value = [aws_subnet.public.*.arn]
}

output "route_table_id" {
  value = element(concat(aws_route_table.public.*.id, [""]), 0)
}

