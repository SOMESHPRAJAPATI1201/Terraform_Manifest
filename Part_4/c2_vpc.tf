
resource "aws_instance" "e2-instance" {
  ami               = "ami-08b5b3a93ed654d19"
  availability_zone = "us-east-1b"
  instance_type     = "t2.micro"
  tags = {
    "Name" = "myec2-user"
    "tag1" = "myec2-user"
  }
}