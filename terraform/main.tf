terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  # backend "s3" {
  #   bucket = "my-tf-1890"
  #   key    = "terraform.tfstate"
  #   region = "ap-south-1"
  #   dynamodb_table = "tf-table"
  # }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}


resource "aws_vpc" "ownvpc" {
  cidr_block = var.vpc_cidr_block
  tags={
    Name="${var.env}-vpc"
  }
}

module "my-subnet"{
  source="./modules/subnet"
  vpc_id = aws_vpc.ownvpc.id
  subnet_cidr_block = var.subnet_cidr_block
  az = var.az
  env=var.env
}

module "my-server"{
  source = "./modules/webserver"
  vpc_id = aws_vpc.ownvpc.id
  subnet_id = module.my-subnet.subnet.id
  env = var.env
  instance_type = var.instance_type
}