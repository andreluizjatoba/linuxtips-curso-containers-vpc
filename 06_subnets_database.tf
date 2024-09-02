######## SUBNETS ########
resource "aws_subnet" "subnets_database" {
  count = length(var.subnets_database_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.subnets_database_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.project_name}-database-subnet-${element(var.azs, count.index)}"
  }
}
