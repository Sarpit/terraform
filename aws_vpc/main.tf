resource "aws_vpc" "demo_vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "Demo-vpc"
  }
}

resource "aws_subnet" "demo_vpc_subnet1" {
  cidr_block = var.cidr_subnet1
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "Demo-vpc-subnet1"
  }
}

resource "aws_internet_gateway" "demo_vpc_ig" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo-vpc-ig"
  }
}

resource "aws_route_table" "demo_vpc_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_vpc_ig.id
  } 
  tags = {
    Name = "demo-vpc-rt"
  }
}

resource "aws_route_table_association" "rt_to_subnet_association" {
  route_table_id = aws_route_table.demo_vpc_rt.id
  subnet_id = aws_subnet.demo_vpc_subnet1.id
}

output "rt_id" {
  value = aws_route_table.demo_vpc_rt.id
}


output "ig_id" {
  value = aws_internet_gateway.demo_vpc_ig.id
}


output "vpc_id" {
  value = aws_vpc.demo_vpc.id
}

output "subnet1_id" {
  value = aws_subnet.demo_vpc_subnet1.id
}
