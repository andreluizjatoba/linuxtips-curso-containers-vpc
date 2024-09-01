locals {
  subnets_private = {
    a = "10.0.0.0/20"
    b = "10.0.16.0/20"
    c = "10.0.32.0/20"
  }
}

######## SUBNETS ########
resource "aws_subnet" "subnets_private" {
  for_each = local.subnets_private

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = format("%s${each.key}", var.region)

  tags = {
    Name = format("%s-private-subnet-1${each.key}", var.project_name)
  }
}

######## ROUTE TABLE ########
resource "aws_route_table" "private_internet_access" {
  for_each = local.subnets_private

  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-private-1-${each.key}", var.project_name)
  }
}

######## DEFAULT ROUTE ########
resource "aws_route" "private_access" {
  for_each = local.subnets_private

  route_table_id         = aws_route_table.private_internet_access["${each.key}"].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat["${each.key}"].id
}

######## ROUTE TABLE ASSOCIATION ########
resource "aws_route_table_association" "private" {
  for_each = local.subnets_private

  subnet_id      = aws_subnet.subnets_private["${each.key}"].id
  route_table_id = aws_route_table.private_internet_access["${each.key}"].id
}