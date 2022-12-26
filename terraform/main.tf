terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}
provider "aws" {
  # Configuration options

}

resource "aws_vpc" "ownvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "own-vpc"
  }
}

module "mysubnet"{
  source = "./modules/subnet"
  vpc_id = aws_vpc.ownvpc.id
  subnet_cidr = var.subnet_cidr
  az = var.az
  env= var.env
}


module "mywebserver"{
  source = "./modules/webserver"
  vpc_id = aws_vpc.ownvpc.id
  subnet_id = module.mysubnet.subnet.id
  instance_type = var.instance_type
  env= var.env
}
