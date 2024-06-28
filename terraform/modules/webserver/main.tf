data "aws_ami" "myami"{
    most_recent = true


  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }


  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }


  owners = ["amazon"] # Canonical
}

#6) security rule

resource "aws_security_group" "mywebsecurity"{
  name = "ownsecurityrules"
  //vpc_id = aws_vpc.main.id
        ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     }

    ingress {
    description      = "SSH"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
     }
     egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = {
    Name = "own-sg"
  }

}

resource "aws_instance" "web" {
  
  ami           = data.aws_ami.myami.id
  instance_type = var.instance_type
  associate_public_ip_address =true
  vpc_security_group_ids = [aws_security_group.mywebsecurity.id]

  //subnet_id = var.subnet_id
  key_name = "ansible"
  #user_data =file("server-script.sh")

  tags = {
    Name = "${terraform.workspace}-tf"
  }
}

