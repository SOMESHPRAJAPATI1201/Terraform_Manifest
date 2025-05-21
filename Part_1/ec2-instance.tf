#teraform block is used to define the required providers
terraform {
  required_version = "~> 1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

#provider block is used to define the AWS provider region and profile
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

# resource block is used to define the AWS EC2 instance
resource "aws_instance" "ec2-user" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
}