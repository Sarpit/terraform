data "aws_vpc" "default" {
  default = true
} 

resource "aws_security_group" "allow_ssh" {
  name        = var.sg 
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_key_pair" "cka_key" {
  key_name = "cka_key"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "cka_instance1" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  key_name = aws_key_pair.cka_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = each.value
  }
  for_each = var.instance

  provisioner "file" {
    source      = "./info.txt"
    destination = "/tmp/info.txt"


   connection {
     user = "ec2-user"
     host = aws_instance.cka_instance1[each.value].public_ip
     private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
   }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/info.txt /etc/"
    ]

    connection {
     user = "ec2-user"
     host = aws_instance.cka_instance1[each.value].public_ip
     private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
 }
}
