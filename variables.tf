variable "access_key" {}
variable "secret_key" {}

variable "region" {
  description = "this to be region"
}
variable "vpc_cidr_block" {}
variable "vpc_tag_name" {}
variable "availability_zone" {}

variable "public_subnet_cidr_block" {}
variable "public_subnet_tag_name" {}

variable "private_subnet_cidr_block" {}
variable "private_subnet_tag_name" {}

variable "internet_gateway_tag_name" {}

variable "route_table_tag_name" {}

variable "security_group_name" {}

variable "ec2_instance_ami" {}
variable "ec2_instance_type" {}
variable "ec2_key_name" {}
variable "ec2_tag_name" {}
