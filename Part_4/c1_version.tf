# This file is used to define the terraform version and the provider version that we are going to use in our terraform code.
terraform {
  required_providers {
    aws = {
      version = "~>3.0"
      source  = "hashicorp/aws"
    }
  }
}

#provider block is used to define the AWS provider region and profile
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}