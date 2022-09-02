output "ec2_public_ip" {
    value = module.myserver-instance.ec2-ip.public_ip
}
output "aws_ami_id"{
    value = module.myserver-instance.ec2-ip.ami
}
output "subnet_id"{
    value = module.myserver-subnet.subnet.id
}