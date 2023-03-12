resource "aws_instance" "web_instance" {
  ami           = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  key_name      = var.ec2_key_name

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = true

  tags = {
    "Name" : var.ec2_tag_name
  }
}