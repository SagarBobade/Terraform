variable "access_key" {
  type = string
  sensitive = true
}
variable "secret_key" {
  type = string
  sensitive = true
}

variable "region" {
  type = string
  description = "this to be region"
}
variable "vpc_cidr_block" {
  type = string
}
variable "vpc_tag_name" {
  type = string
}
variable "availability_zone" {
  type = string
  default = "ap-south-1"
}

variable "public_subnet_cidr_block" {
  type = string
}
variable "public_subnet_tag_name" {
  type = string
}

variable "private_subnet_cidr_block" {
  type = string
}
variable "private_subnet_tag_name" {
  type = string
}

variable "internet_gateway_tag_name" {
  type = string
}

variable "route_table_tag_name" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "ec2_instance_ami" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "ec2_tag_name" {
  type = string
}