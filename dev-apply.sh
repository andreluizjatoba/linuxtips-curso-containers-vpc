#!/bin/bash

AWS_PROFILE=andre-labs-dev terraform appy -var-file=environment/dev/terraform.tfvars
