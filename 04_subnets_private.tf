######## SUBNETS ########
resource "aws_subnet" "subnets_private" {
  count = length(var.subnets_private_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets_private_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-private-subnet-${element(var.azs, count.index)}"
  }
}

######## ROUTE TABLES ########
resource "aws_route_table" "private_internet_access" {
  count = length(var.subnets_private_cidrs)

  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-rtb-private-subnet-${element(var.azs, count.index)}", var.project_name)
  }
}

######## ROUTES ########
resource "aws_route" "private_access" {
  count = length(var.subnets_private_cidrs)

  route_table_id         = aws_route_table.private_internet_access[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

######## ROUTE TABLE ASSOCIATIONS ########
resource "aws_route_table_association" "subnets_private" {
  count = length(var.subnets_private_cidrs)

  subnet_id      = aws_subnet.subnets_private[count.index].id
  route_table_id = aws_route_table.private_internet_access[count.index].id
}
