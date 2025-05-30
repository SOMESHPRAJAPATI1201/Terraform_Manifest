
resource "aws_instance" "pb_compute_instance" {
  ami           = "ami-0953476d60561c955" # Ubuntu Server 20.04 LTS in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name = "terraform-somesh-key"
  vpc_security_group_ids = [ aws_security_group.pb_compute_sg.id ]
  associate_public_ip_address = true
    # user_data = <<-EOF
    #             #!/bin/bash
    #             apt-get update
    #             apt-get install -y python3-pip
    #             pip3 install --upgrade pip
    #             EOF

  tags = {
    Name = "PBComputeInstance"
  }
}


resource "aws_instance" "pv_compute_instance" {
  ami           = "ami-0953476d60561c955" # Ubuntu Server 20.04 LTS in us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id
  iam_instance_profile = aws_iam_instance_profile.s3_access_profile.name
  key_name = "terraform-somesh-key"
  vpc_security_group_ids = [ aws_security_group.pv_compute_sg.id ]
    # user_data = <<-EOF
    #             #!/bin/bash
    #             apt-get update
    #             apt-get install -y python3-pip
    #             pip3 install --upgrade pip
    #             EOF

  tags = {
    Name = "PVComputeInstance"
  }
}