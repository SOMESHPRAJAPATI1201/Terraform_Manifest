
#create elastic ip
resource "aws_eip" "dev-eip" {
  instance   = aws_instance.ec2-user.id
  vpc        = true
  depends_on = [aws_internet_gateway.dev-igw]
}


#create elastic ip
resource "aws_eip" "qa-eip" {
  instance   = aws_instance.ec2-user1.id
  vpc        = true
  depends_on = [aws_internet_gateway.dev-igw]
}