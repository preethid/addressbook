output "ec2-ip" {
  value = module.myserver-instance.ec2-ip.public_ip
}
output "subnet-id"{
   value = module.myserver-subnet.subnet.id
}