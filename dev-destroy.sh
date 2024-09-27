#!/bin/bash

AWS_PROFILE=andre-labs-dev AWS_REGION=us-east-1 terraform destroy -var-file=environment/dev/terraform.tfvars
