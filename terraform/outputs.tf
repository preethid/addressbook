output "ec2-ip"{
   value=module.myaws-instance.ec2.public_ip
}
output "ami"{
    value=module.myaws-instance.ec2.ami
}
output "subnet-id"{
    value=module.myaws-subnet.subnet.id
}