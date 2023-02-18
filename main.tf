
// we are providing terraform that in order to connect to provider, use below credential

provider "aws" {
  region = "ap-south-1"
  access_key = "ABCD"
  secret_key = "WXYZ"
}


// resource "provider_resource_type" name
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev"
  }
}

 resource "aws_subnet" "dev-public-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "dev-public-subnet"
  }
}

resource "aws_subnet" "dev-private-subnet" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "dev-private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "main"
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
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "dev-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.dev-public-subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "dev-sg" {
  name   = "HTTP and SSH"
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
  ami           = "ami-0caf778a172362f1c"
  instance_type = "t2.micro"
  key_name      = "sagar"

  subnet_id                   = aws_subnet.dev-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.dev-sg.id]
  associate_public_ip_address = true

  tags = {
    "Name" : "my-ec2"
  }
}


// Display output
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