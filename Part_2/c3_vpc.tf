
resource "aws_vpc" "myawswetvpc" {
  cidr_block = "10.0.0.0/16"
  provider = aws.aws-west-1
  tags = {
    Name = "myawswetvpc"
  }
}