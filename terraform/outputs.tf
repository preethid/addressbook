output "ec2-public-ip" {
    value = aws_instance.webserver.public_ip
}

