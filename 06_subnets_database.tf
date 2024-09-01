locals {
  subnets_database = {
    a = "10.0.51.0/24"
    b = "10.0.52.0/24"
    c = "10.0.53.0/24"
  }
}

######## SUBNETS ########
resource "aws_subnet" "subnets_database" {
  for_each = local.subnets_database

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = format("%s${each.key}", var.region)

  tags = {
    Name = format("%s-database-subnet-1${each.key}", var.project_name)
  }
}