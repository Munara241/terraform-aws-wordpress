provider "aws" {
  region = var.region
}

resource "aws_vpc" "project3" {
  cidr_block           = var.vpc_dns[0].vpc_cidr
  enable_dns_support   = var.vpc_dns[0].dns_sup
  enable_dns_hostnames = var.vpc_dns[0].dns_host

  tags = {
    Name = var.vpc_dns[0].vpc_name
  }
}

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.project3.id
  cidr_block              = var.subnet_cidr[0].cidr
  map_public_ip_on_launch = true             # enable the public_ip
  availability_zone       = "${var.region}a" # == "us-west-2a"

  tags = {
    Name = var.subnet_cidr[0].subnet_name
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.project3.id
  cidr_block              = var.subnet_cidr[1].cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b" # == "us-west-2b"

  tags = {
    Name = var.subnet_cidr[1].subnet_name
  }
}

resource "aws_subnet" "public3" {
  vpc_id            = aws_vpc.project3.id
  cidr_block        = var.subnet_cidr[2].cidr
  map_public_ip_on_launch = true
  availability_zone = "${var.region}c" # == "us-west-2c"

  tags = {
    Name = var.subnet_cidr[2].subnet_name
  }
}


resource "aws_internet_gateway" "project3" {
  vpc_id = aws_vpc.project3.id

 
}

# Route table with name public, associate 2 public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.project3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project3.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public.id
}

resource "aws_key_pair" "wordpress" {
  key_name   = "wordpress_key_name"
  public_key = file("~/.ssh/id_rsa.pub")
}
