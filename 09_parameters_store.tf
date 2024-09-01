##### VPC
resource "aws_ssm_parameter" "vpc" {
  name  = format("/%s/vpc/vpc_id", var.project_name)
  type  = "String"
  value = aws_vpc.main.id
}

locals {
  subnets = {
    a = "1a"
    b = "1b"
    c = "1c"
  }
}

##### SUBNETS PRIVATE
resource "aws_ssm_parameter" "subnets_private" {
  for_each = local.subnets

  name  = format("/%s/vpc/subnet_private_${each.value}", var.project_name)
  type  = "String"
  value = aws_subnet.subnets_private["${each.key}"].id
}

##### SUBNETS PUBLIC
resource "aws_ssm_parameter" "subnets_public" {
  for_each = local.subnets

  name  = format("/%s/vpc/subnet_public_${each.value}", var.project_name)
  type  = "String"
  value = aws_subnet.subnets_public["${each.key}"].id
}

##### SUBNETS DATABASE
resource "aws_ssm_parameter" "subnets_database" {
  for_each = local.subnets

  name  = format("/%s/vpc/subnet_database_${each.value}", var.project_name)
  type  = "String"
  value = aws_subnet.subnets_database["${each.key}"].id
}
