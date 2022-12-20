
// we are providing terraform that in order to connect to provider, use below credential

provider "aws" {
  region = "ap-south-1"
  access_key = "ABCD"
  secret_key = "XYZ"
}


// declare variable
// we can use ":" or "=" sign but "=" is right syntax
// value to be enter like "172.31.48.0/20"
variable "cidr_blocks" {
  description = "vpc cidr block"
//  default = "10.0.0.0/16"
  type = list(string)
}

variable "environment" {
  description = "vpc for development environment"
}

// resource "provider_resource_type" name
// we mention here resource and or data
resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0]
  tags = {
    Name = var.environment
  }
}

 resource "aws_subnet" "development-subnet" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "development-subnet"
  }
}

//data
data "aws_vpc" "existing_vpc"{
  default = true
}


// create new subnet inside default vpc 
 resource "aws_subnet" "development-subnet2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = var.cidr_blocks[1]
  availability_zone = "ap-south-1a"
  tags = {
    Name = "development-subnet 2"
  }
}

// Below section is used to display output
output "vpc_id" {
  value = aws_vpc.development-vpc.id
}

output "subnet_id-1" {
  value = aws_subnet.development-subnet.id
}

output "subnet_id_1" {
  value = aws_subnet.development-subnet2.id
}