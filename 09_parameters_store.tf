##### VPC ########
resource "aws_ssm_parameter" "vpc_id" {
  count = var.enabled_ssm_parameters ? 1 : 0

  name  = format("/%s/vpc/vpc_id", var.project_name)
  type  = "String"
  value = aws_vpc.main.id
}

######## SUBNETS ########
resource "aws_ssm_parameter" "subnets_id" {
  count = var.enabled_ssm_parameters ? length(concat(aws_subnet.subnets_private[*].id, aws_subnet.subnets_public[*].id, aws_subnet.subnets_database[*].id)) : 0

  name = format("/%s/vpc/%s", var.project_name, element(concat(aws_subnet.subnets_private[*].tags["Name"], aws_subnet.subnets_public[*].tags["Name"], aws_subnet.subnets_database[*].tags["Name"]), count.index))

  type  = "String"
  value = element(concat(aws_subnet.subnets_private[*].id, aws_subnet.subnets_public[*].id, aws_subnet.subnets_database[*].id), count.index)
}
