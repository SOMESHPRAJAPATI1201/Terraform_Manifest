terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}


provider "aws" {
  profile = "default" # Ensure you have the AWS CLI configured with this profile
  region = "us-east-1"
}

resource "aws_vpc" "instance_vpc" {
  cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "InstanceVPC"
    }
}

resource "aws_security_group" "pv_compute_sg" {
  name        = "pv_compute_sg"
  description = "Security group for PV Compute instance"
  vpc_id      = aws_vpc.instance_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"] # Allow SSH from anywhere, consider restricting this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "PVComputeSG"
    }  
}

resource "aws_security_group" "pb_compute_sg" {
  name        = "pb_compute_sg"
  description = "Security group for PB Compute instance"
  vpc_id      = aws_vpc.instance_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere, consider restricting this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = {
        Name = "PBComputeSG"
    }  
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.instance_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
    tags = {
        Name = "PublicSubnet"
    }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.instance_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "PrivateSubnet"
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.instance_vpc.id
    tags = {
        Name = "InstanceIGW"
    }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.instance_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
    tags = {
        Name = "PublicRouteTable"
    }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.instance_vpc.id
    tags = {
        Name = "PrivateRouteTable"
    }
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}