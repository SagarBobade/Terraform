
output "vpc_id" {
  value = aws_vpc.dev-vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.dev-public-subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.dev-private-subnet.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "route_table_id" {
  value = aws_route_table.route_table.id
}

output "aws_security_group_id" {
  value = aws_security_group.dev-sg.id  
}

output "aws_instance_id" {
  value = aws_instance.web_instance.id
}