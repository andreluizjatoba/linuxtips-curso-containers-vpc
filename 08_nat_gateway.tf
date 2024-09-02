resource "aws_eip" "vpc_eip" {
  count = var.enabled_nat_gateway ? length(var.subnets_private_cidrs) : 0

  domain = "vpc"

  tags = {
    Name = format("%s-eip-%s", var.project_name, element(var.azs, count.index))
  }
}

resource "aws_nat_gateway" "nat" {
  count = var.enabled_nat_gateway ? length(var.subnets_private_cidrs) : 0

  allocation_id = aws_eip.vpc_eip[count.index].id
  subnet_id     = aws_subnet.subnets_private[count.index].id

  tags = {
    Name = format("%s-nat-%s", var.project_name, element(var.azs, count.index))
  }

  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.vpc_eip
  ]
}
