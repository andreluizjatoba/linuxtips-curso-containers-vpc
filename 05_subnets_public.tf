######## SUBNETS ########
resource "aws_subnet" "subnets_public" {
  count = length(var.subnets_public_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets_public_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-public-subnet-${element(var.azs, count.index)}"
  }
}

######## ROUTE TABLES ########
resource "aws_route_table" "public_internet_access" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-rtb-public", var.project_name)
  }
}

######## ROUTES ########
resource "aws_route" "public_access" {
  route_table_id         = aws_route_table.public_internet_access.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_internet_gateway.igw]
}

######## ROUTE TABLE ASSOCIATIONS ########
resource "aws_route_table_association" "pulic" {
  count = length(var.subnets_public_cidrs)

  subnet_id      = aws_subnet.subnets_public[count.index].id
  route_table_id = aws_route_table.public_internet_access.id
}
