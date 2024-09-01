#!/bin/bash

AWS_PROFILE=andre-labs-dev terraform destroy -var-file=environment/dev/terraform.tfvars
