terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      managed     = "terraform"
      project     = "${var.project_name}"
      environment = "${var.environment}"

    }
  }
}

