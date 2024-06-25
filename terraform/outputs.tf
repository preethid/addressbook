output "ec2_ip" {
  value=module.webserver.ec2.public_ip
}