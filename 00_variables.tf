######## General Configs ########

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente default para deploy"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Regiao da AWS"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  description = "Lista de zonas de disponibilidades"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  type        = string
}

variable "subnets_private_cidrs" {
  description = "Lista dos blocos CIDR para as subnets privadas"
  type        = list(string)
}

variable "subnets_public_cidrs" {
  description = "Lista dos blocos CIDR para as subnets publicas"
  type        = list(string)
}

variable "subnets_database_cidrs" {
  description = "Lista dos blocos CIDR para as subnets databases"
  type        = list(string)
}

variable "enabled_nat_gateway" {
  description = "Habilitar NAT Gateway"
  type        = bool
}

variable "enabled_ssm_parameters" {
  description = "Habilitar ou desabilitar a criação dos parametros no SSM"
  type        = bool
  default     = true
}

variable "enabled_public_route_table" {
  description = "Habilitar ou desabilitar a criação da tabela de rotas publica"
  type        = bool
  default     = true
}













