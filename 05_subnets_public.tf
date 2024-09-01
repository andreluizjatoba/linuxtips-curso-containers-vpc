locals {
  subnets_public = {
    a = "10.0.48.0/24"
    b = "10.0.49.0/24"
    c = "10.0.50.0/24"
  }
}

##### SUBNETS
resource "aws_subnet" "subnets_public" {
  for_each = local.subnets_public

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = format("%s${each.key}", var.region)

  tags = {
    Name = format("%s-public-subnet-1${each.key}", var.project_name)
  }
}

##### ROUTE TABLE
resource "aws_route_table" "public_internet_access" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-public", var.project_name)
  }
}

##### DEFAULT ROUTE
resource "aws_route" "public_access" {
  depends_on             = [aws_internet_gateway.igw]
  route_table_id         = aws_route_table.public_internet_access.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

##### ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "pulic" {
  for_each = local.subnets_public

  subnet_id      = aws_subnet.subnets_public["${each.key}"].id
  route_table_id = aws_route_table.public_internet_access.id
}
