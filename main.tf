
// we are providing terraform that in order to connect to provider, use below credential

resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_tag_name
  }
}

 resource "aws_subnet" "dev-public-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = var.public_subnet_tag_name
  }
}

resource "aws_subnet" "dev-private-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = var.private_subnet_cidr_block
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = var.internet_gateway_tag_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.dev-vpc.id

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

resource "aws_security_group" "dev-sg" {
  name   = var.security_group_name
  vpc_id = aws_vpc.dev-vpc.id

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name

  subnet_id                   = aws_subnet.dev-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.dev-sg.id]
  associate_public_ip_address = true

  tags = {
    "Name" : var.ec2_tag_name
  }
}