#2) subnet
resource "aws_subnet" "ownsubnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone=var.az
 
  tags = {
    Name = "${var.env}-subnet"
  }
}
# 3)igw
resource "aws_internet_gateway" "ownigw" {
  vpc_id = var.vpc_id
 
  tags = {
    Name = "${var.env}-igw"
  }
}
# 4) rt

resource "aws_route_table" "ownrt" {
  vpc_id = var.vpc_id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ownigw.id
  }
  tags={
    Name: "${var.env}-rt"
  }
}
# 5) associate the rt table to the subnet
resource "aws_route_table_association" "rta_subnet" {
  subnet_id      = aws_subnet.ownsubnet.id
  route_table_id = aws_route_table.ownrt.id
}