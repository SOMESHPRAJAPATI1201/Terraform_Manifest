# This file is used to define the terraform version and the provider version that we are going to use in our terraform code.
terraform {
    required_providers {
        aws = {
        version = "<3.0"
        source  = "hashicorp/aws"
        }
        random = {
        source  = "hashicorp/random"
        }
    }
}

#provider block is used to define the AWS provider region and profile
provider "aws" {
    region = "us-east-1"
    profile = "default"
}