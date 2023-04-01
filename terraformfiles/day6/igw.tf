# Creating internet gateway
resource "aws_internet_gateway" "ntier_igw" {
  tags      = {
    Name    = "ntier-igw"
  }
  vpc_id    = aws_vpc.primary_vpc.id

}

# create a route table
resource "aws_route_table" "public_rt" {
  vpc_id      = aws_vpc.primary_vpc.id
  tags        = {
    Name      = "public"
  }

  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.ntier_igw.id
  }

}

resource "aws_route_table" "private_rt" {
  vpc_id      = aws_vpc.primary_vpc.id
  tags        = {
    Name      = "private"
  }

}

# Associate public route table with web subnets

resource "aws_route_table_association" "web1_public_association" {
  route_table_id  = aws_route_table.public_rt.id
  subnet_id       = aws_subnet.subnets[0].id
}

resource "aws_route_table_association" "web2_public_association" {
  route_table_id  = aws_route_table.public_rt.id
  subnet_id       = aws_subnet.subnets[1].id
}

resource "aws_route_table_association" "db1_private_association" {
  route_table_id  = aws_route_table.private_rt.id
  subnet_id       = aws_subnet.subnets[2].id
}

resource "aws_route_table_association" "db2_private_association" {
  route_table_id  = aws_route_table.private_rt.id
  subnet_id       = aws_subnet.subnets[3].id
}