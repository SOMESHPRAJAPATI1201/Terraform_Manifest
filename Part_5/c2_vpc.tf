
# Create a VPC
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

# Create a subnet
resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "dev-subnet"
  }
}


# Create a subnet
resource "aws_subnet" "qa-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "qa-subnet"
  }
}


# Create an internet gateway
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev-vpc.id
  tags = {
    Name = "dev-igw"
  }
}

# Create a route table
resource "aws_route_table" "dev-rt" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-igw.id
  }
  tags = {
    Name = "dev-rt"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "dev-rt-assoc_1" {
  subnet_id      = aws_subnet.dev-subnet.id
  route_table_id = aws_route_table.dev-rt.id
}

# Associate the route table with the subnet
resource "aws_route_table_association" "dev-rt-assoc_2" {
  subnet_id      = aws_subnet.qa-subnet.id
  route_table_id = aws_route_table.dev-rt.id
}

# Create a security group
resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "testing security group"
  vpc_id      = aws_vpc.dev-vpc.id
  ingress {
    description = "HTTPS for VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH for VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}