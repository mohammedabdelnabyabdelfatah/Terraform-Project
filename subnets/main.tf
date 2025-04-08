resource "aws_subnet" "public_az1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr_az1
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az1"
  }
}

resource "aws_subnet" "public_az2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidr_az2
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-az2"
  }
}

resource "aws_subnet" "private_az1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr_az1
  availability_zone = var.az1

  tags = {
    Name = "private-subnet-az1"
  }
}

resource "aws_subnet" "private_az2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_cidr_az2
  availability_zone = var.az2

  tags = {
    Name = "private-subnet-az2"
  }
}
