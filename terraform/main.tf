terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
  # backend "s3"{
  #     bucket="tf-bucket-backends"
  #       key="terraform.tfstate"
  #       region="ap-south-1"
  #       dynamodb_table="tf-table"

  # }
}

provider "aws" {
  region = "ap-south-1"
  #   access_key = "my-access-key"
  #   secret_key = "my-secret-key"
}

#1) create vpc

resource "aws_vpc" "ownvpc"{
  cidr_block = var.vpc_cidr_block
  tags={
    Name="own-vpc"
  }

}

module "mysubnet" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.ownvpc.id
  subnet_cidr_block = var.subnet_cidr_block
  az = var.az
  env = var.env
}

module "webserver"{
  source = "./modules/webserver"
  vpc_id = aws_vpc.ownvpc.id
  subnet_id = module.mysubnet.subnet.id
  env = var.env
  instance_type = var.instance_type
}

