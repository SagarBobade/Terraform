resource "aws_subnet" "dev-public-subnet" {
  vpc_id = var.vpc_Id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = var.public_subnet_tag_name
  }
}

resource "aws_subnet" "dev-private-subnet" {
  vpc_id = var.vpc_Id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = var.private_subnet_cidr_block
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_Id

  tags = {
    Name = var.internet_gateway_tag_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_Id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_tag_name
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.dev-public-subnet.id
  route_table_id = aws_route_table.route_table.id
}
