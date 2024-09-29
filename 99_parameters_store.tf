locals {
  parameter_prefix = format("/%s/%s", var.project_name, var.environment)
}

##### VPC ########
resource "aws_ssm_parameter" "vpc_id" {
  count = var.enabled_ssm_parameters ? 1 : 0

  name  = "${local.parameter_prefix}/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
}

/*
######## SUBNETS ########
resource "aws_ssm_parameter" "subnets_id" {
  count = var.enabled_ssm_parameters ? length(concat(aws_subnet.subnets_private[*].id, aws_subnet.subnets_public[*].id, aws_subnet.subnets_database[*].id)) : 0

  name = format("/%s/%s/%s", var.project_name, var.environment, element(concat(aws_subnet.subnets_private[*].tags["Name"], aws_subnet.subnets_public[*].tags["Name"], aws_subnet.subnets_database[*].tags["Name"]), count.index))

  type  = "String"
  value = element(concat(aws_subnet.subnets_private[*].id, aws_subnet.subnets_public[*].id, aws_subnet.subnets_database[*].id), count.index)
}
*/

######## SUBNETS PRIVATE ########
resource "aws_ssm_parameter" "subnets_private" {
  count = var.enabled_ssm_parameters ? length(aws_subnet.subnets_private[*].id) : 0

  name  = format("${local.parameter_prefix}/private-subnet-${element(var.azs, count.index)}")
  type  = "String"
  value = element(aws_subnet.subnets_private[*].id, count.index)
}

######## SUBNETS PUBLIC ########
resource "aws_ssm_parameter" "subnets_public" {
  count = var.enabled_ssm_parameters ? length(aws_subnet.subnets_public[*].id) : 0

  name  = format("${local.parameter_prefix}/public-subnet-${element(var.azs, count.index)}")
  type  = "String"
  value = element(aws_subnet.subnets_public[*].id, count.index)
}

######## SUBNETS DATABASE ########
resource "aws_ssm_parameter" "subnets_database" {
  count = var.enabled_ssm_parameters ? length(aws_subnet.subnets_database[*].id) : 0

  name  = format("${local.parameter_prefix}/database-subnet-${element(var.azs, count.index)}")
  type  = "String"
  value = element(aws_subnet.subnets_database[*].id, count.index)
}
