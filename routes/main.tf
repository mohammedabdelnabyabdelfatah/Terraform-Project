resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_az1" {
  subnet_id      = var.public_subnet_az1_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_az2" {
  subnet_id      = var.public_subnet_az2_id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_az1" {
  subnet_id      = var.private_subnet_az1_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_az2" {
  subnet_id      = var.private_subnet_az2_id
  route_table_id = aws_route_table.private.id
}
