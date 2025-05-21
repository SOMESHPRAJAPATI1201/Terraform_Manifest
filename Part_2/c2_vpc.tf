
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}

# resource block is used to define the AWS EC2 instance
resource "aws_instance" "ec2-user" {
  ami           = "ami-08b5b3a93ed654d19"
  instance_type = "t2.micro"
}