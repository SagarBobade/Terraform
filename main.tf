
// we are providing terraform that in order to connect to provider, use below credential

resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_tag_name
  }
}

module "myvpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  availability_zone = var.availability_zone
  private_subnet_cidr_block = var.private_subnet_cidr_block
  internet_gateway_tag_name = var.internet_gateway_tag_name
  route_table_tag_name = var.route_table_tag_name
  vpc_Id = aws_vpc.dev-vpc.id
  public_subnet_tag_name = var.public_subnet_tag_name
  public_subnet_cidr_block = var.public_subnet_cidr_block
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

module "web_instance" {
  source = "./modules/ec2"
  ec2_instance_ami  = var.ec2_instance_ami
  ec2_instance_type = var.ec2_instance_type
  ec2_key_name      = var.ec2_key_name
  subnet_id                   = module.myvpc.subnet.id
  vpc_security_group_ids      = aws_security_group.dev-sg.id
  ec2_tag_name = var.ec2_tag_name
}