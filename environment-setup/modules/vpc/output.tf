output "private-route-table-id" {
  description = "Route table id with which the private subnets should be associated"
  value       = aws_route_table.private-route-table.id
}

output "public-route-table-id" {
  description = "Route table id with which the public subnet should be associated"
  value       = aws_route_table.public-route-table.id
}
output "allocation-id-for-nat-eip" {
  description = "The allocation id of the NAT EIP"
  value       = aws_eip.nat-eip.id
}
