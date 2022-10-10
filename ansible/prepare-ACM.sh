#! /usr/bin/env bash
pip3 install ansible
pip3 install boto3
aws configure set aws_access_key_id $1
aws configure set aws_secret_access_key $2
/home/ec2-user/.local/bin/ansible-inventory -i /home/ec2-user/ansible/inventory_aws_ec2.yml --graph
/home/ec2-user/.local/bin/ansible-playbook -i /home/ec2-user/ansible/inventory_aws_ec2.yml  /home/ec2-user/ansible/docker-deploy.yml -e "DOCKER_IMAGE=$4 DOCKER_REG_PASSWORD=$3"
rm /home/ec2-user/.ssh/id_rsa