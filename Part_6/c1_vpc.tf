terraform {
  required_providers {
    aws = {
      version = "~>3.0"
      source  = "hashicorp/aws"
    }
  }
}


provider "aws" {
  region  = "us-east-1"
  profile = "default"  
}

resource "aws_vpc" "infra_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
    tags = {
        Name = "infra-vpc"
    }
}

resource "aws_security_group" "infra_sg" {
  vpc_id = aws_vpc.infra_vpc.id
  name   = "infra-sg"
  description = "Security group for EC2 instances"

    ingress {
    description = "Postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # change to your IP for security
  }

  ingress {
    from_port   = 21
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow FTP from anywhere
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "infra-sg"
    }
}

resource "aws_subnet" "infra_pb_subnet" {
  vpc_id            = aws_vpc.infra_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
    tags = {
        Name = "infra-pb-subnet"
    }
}

resource "aws_internet_gateway" "infra_igw" {
  vpc_id = aws_vpc.infra_vpc.id
    tags = {
        Name = "infra-igw"
    }
}

resource "aws_route_table" "infra_route_table" {
  vpc_id = aws_vpc.infra_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra_igw.id
  }
    tags = {
        Name = "infra-route-table"
    }
}

resource "aws_route_table_association" "infra_route_table_association" {
  subnet_id      = aws_subnet.infra_pb_subnet.id
  route_table_id = aws_route_table.infra_route_table.id
}



