locals {
  nat_gateways = {
    a = "1a"
    b = "1b"
    c = "1c"
  }

}

resource "aws_eip" "vpc_eip" {
  for_each = local.nat_gateways

  domain = "vpc"

  tags = {
    Name = format("%s-eip-${each.value}", var.project_name)
  }
}

resource "aws_nat_gateway" "nat" {
  for_each = local.nat_gateways

  allocation_id = aws_eip.vpc_eip["${each.key}"].id
  subnet_id     = aws_subnet.subnets_public["${each.key}"].id

  tags = {
    Name = format("%s-nat-${each.value}", var.project_name)
  }
}