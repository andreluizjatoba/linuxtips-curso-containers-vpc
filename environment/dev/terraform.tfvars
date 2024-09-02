project_name = "linuxtips-vpc"
environment  = "dev"

region = "us-east-1"
azs    = ["us-east-1a", "us-east-1b", "us-east-1c"]

vpc_cidr = "10.0.0.0/16"

subnets_private_cidrs  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
subnets_public_cidrs   = ["10.0.48.0/24", "10.0.49.0/24", "10.0.50.0/24"]
subnets_database_cidrs = ["10.0.51.0/24", "10.0.52.0/24", "10.0.53.0/24"]

enabled_nat_gateway    = true
enabled_ssm_parameters = true