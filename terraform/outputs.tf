
output "ec2-ip" {

  value = module.myserver-instance.ec2-ip.public_ip
  
}

output "aws_ami_id" {
     value = module.myserver-instance.ec2-ip.ami
}