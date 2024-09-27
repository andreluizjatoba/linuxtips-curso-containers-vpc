#!/bin/bash

AWS_PROFILE=andre-labs-dev AWS_REGION=us-east-1 terraform appy -var-file=environment/dev/terraform.tfvars
