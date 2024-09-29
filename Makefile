.PHONY: help, init, plan, apply, destroy, clean, tfdocs

help:
	@grep -h "##" $(MAKEFILE_LIST) | grep -F -v grep | sed -e 's/\\$$//' | sed -e 's/##//'

.DEFAULT_GOAL := help

# Variável de ambiente, padrão para "dev"
ENVIRONMENT ?= dev

# Variável de ambiente, padrão para o AWS Profile
AWS_PROFILE ?= andre-labs-dev

# Variável de ambiente, padrão para a região da AWS
AWS_REGION ?= us-east-1

## ------------------------------------
## Terraform
##
## Definições padrões (default)
## AWS_PROFILE=default
## AWS_REGION=us-east-1
## ENVIRONMENT=dev
##
## ------------------------------------

## make init AWS_PROFILE=[nome do profile] ENVIRONMENT=[dev|prod] - Terraform init
init:
	@AWS_PROFILE=$(AWS_PROFILE) AWS_REGION=$(AWS_REGION) terraform init -var-file=environment/$(ENVIRONMENT)/backend.tfvars

validate:
	@terraform validate
	@terraform fmt --recursive

## make plan AWS_PROFILE=[nome do profile] ENVIRONMENT=[dev|prod] - Terraform plan
plan: validate
	@AWS_PROFILE=$(AWS_PROFILE) AWS_REGION=$(AWS_REGION) terraform plan -var-file=environment/$(ENVIRONMENT)/terraform.tfvars

## make apply AWS_PROFILE=[nome do profile] ENVIRONMENT=[dev|prod] - Terraform apply
apply:
	@AWS_PROFILE=$(AWS_PROFILE) AWS_REGION=$(AWS_REGION) terraform apply --auto-approve -var-file=environment/$(ENVIRONMENT)/terraform.tfvars

## make destroy AWS_PROFILE=[nome do profile] ENVIRONMENT=[dev|prod] - Terraform destroy
destroy: validate
	@AWS_PROFILE=$(AWS_PROFILE) AWS_REGION=$(AWS_REGION) terraform destroy -var-file=environment/$(ENVIRONMENT)/terraform.tfvars

## make tfdocs - Gerar documentação do Terraform
tfdocs:
	@docker run --rm --volume "$$(pwd):/terraform-docs" -u $$(id -u) quay.io/terraform-docs/terraform-docs:0.18.0 markdown /terraform-docs > docs/tfdoc.md

## make clean - remover variáveis de ambiente
clean:
	@rm -rf terraform.* .terraform.* .terraform* plan *-config
