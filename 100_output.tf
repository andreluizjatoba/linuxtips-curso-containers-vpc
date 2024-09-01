##### VPC
output "ssm_vpc_id" {
  value = aws_ssm_parameter.vpc.id
}

##### SUBNETS PRIVATE
output "subnets_private" {
  value = tomap({
    for s, ssm in aws_ssm_parameter.subnets_private : s => {
      ssm = ssm.id
    }
  })
}

##### SUBNETS PUBLIC
output "subnets_public" {
  value = tomap({
    for s, ssm in aws_ssm_parameter.subnets_public : s => {
      ssm = ssm.id
    }
  })
}

##### SUBNETS DATABASE
output "subnets_database" {
  value = tomap({
    for s, ssm in aws_ssm_parameter.subnets_database : s => {
      ssm = ssm.id
    }
  })
}
