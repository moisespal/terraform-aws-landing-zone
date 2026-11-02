resource "aws_vpc" "main" {
  provider   = aws.network
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Landing Zone VPC"
  }
}

resource "aws_subnet" "public_subnets" {
  provider          = aws.network
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  provider          = aws.network
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gateway" {
  provider = aws.network
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "Landing Zone VPC IGW"
  }
}

resource "aws_route_table" "second_route_table" {
  provider = aws.network
  vpc_id   = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Landing Zone Public Route Table"
  }
}

resource "aws_route_table_association" "second_association" {
  provider       = aws.network
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.second_route_table.id
}

