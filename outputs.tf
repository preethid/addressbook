output "subnet" {
    value = module.mysubnet.subnet.id
}

output "ec2" {
  value = module.myserver.ec2.public_ip
}