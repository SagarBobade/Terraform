output "subnet" {
  value = aws_subnet.dev-public-subnet
}

# output "public_subnet_id" {
#   value = aws_subnet.dev-public-subnet.id
# }

output "private_subnet_id" {
  value = aws_subnet.dev-private-subnet.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_id" {
  value = aws_route_table.route_table.id
}
