
#ec2_instance
resource "aws_instance" "ec2-user" {
  ami                    = "ami-08b5b3a93ed654d19"
  instance_type          = "t2.micro"
  key_name               = "terraform-somesh-key"
  subnet_id              = aws_subnet.dev-subnet.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  # user_data = file("apache-install.sh")
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Terraform, Instance 1</h1>" | sudo tee /var/www/html/index.html
              EOF
  tags = {
    Name = "ec2-user"
  }
}

#ec2_instance
resource "aws_instance" "ec2-user1" {
  ami                    = "ami-08b5b3a93ed654d19"
  instance_type          = "t2.micro"
  key_name               = "terraform-somesh-key"
  subnet_id              = aws_subnet.qa-subnet.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  # user_data = file("apache-install.sh")
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Welcome to Terraform, Instance 2</h1>" | sudo tee /var/www/html/index.html
              EOF
  tags = {
    Name = "ec2-user"
  }
}