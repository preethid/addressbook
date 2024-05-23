terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.50.0"
    }
  }
  #  backend "s3" {
  #       bucket="aws-infra-back"
  #       key="terraform.tfstate"
  #       region="ap-south-1"
  #       dynamodb_table="infra-locks"
  #   }

}

provider "aws" {
  # Configuration options
   region     = "ap-south-1"
  
}

#1)vpc
resource "aws_vpc" "ownvpc" {
  cidr_block = var.vpc_cidr_block
  tags={
    Name="own-vpc"
  }
}

module "mysubnet"{
  source = "./modules/subnet"
  vpc_id = aws_vpc.ownvpc.id
  subnet_cidr_block = var.subnet_cidr_block
  az=var.az
  env=var.env
}

module "myserver" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.ownvpc.id
  subnet_id = module.mysubnet.subnet.id 
  env =var.env
  instance_type = var.instance_type
}