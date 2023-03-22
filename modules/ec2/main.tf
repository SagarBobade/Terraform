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

resource "null_resource" "example" {
  provisioner "remote-exec" {
    inline = [
        "sudo ansible-playbook /home/ubuntu/configure.yml -i my-hosts"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("/home/sagar/Desktop/Keys/dev-sagar.pem")}"
      host        = "13.212.192.118"
    }
  }
}
