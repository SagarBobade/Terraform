
output "vpc_id" {
  value = aws_vpc.dev-vpc.id
}

output "aws_security_group_id" {
  value = aws_security_group.dev-sg
}
