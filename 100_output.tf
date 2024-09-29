######## VPC ########
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID da VPC"
}
output "ssm_vpc_id" {
  value = [
    for vpc in aws_ssm_parameter.vpc_id : "${vpc.id}"
  ]
}

##### SUBNETS ########
output "subnets_ids" {
  value = [
    for subnet in concat(aws_subnet.subnets_private, aws_subnet.subnets_public, aws_subnet.subnets_database) :
    "${subnet.tags["Name"]} - ${subnet.id}"
  ]
}
output "ssm_subnets_private_id" {
  value = [
    for subnet in aws_ssm_parameter.subnets_private : "${subnet.id}"
  ]
}
output "ssm_subnets_public_id" {
  value = [
    for subnet in aws_ssm_parameter.subnets_public : "${subnet.id}"
  ]
}
output "ssm_subnets_database_id" {
  value = [
    for subnet in aws_ssm_parameter.subnets_database : "${subnet.id}"
  ]
}
