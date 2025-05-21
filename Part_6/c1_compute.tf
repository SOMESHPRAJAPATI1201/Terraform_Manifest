

resource "aws_instance" "ec2-user" {
    
    ami           = "ami-0953476d60561c955" # Amazon Linux 2 AMI
    instance_type = "t2.micro"  
    associate_public_ip_address = true
    key_name      = "terraform-somesh-key" # Replace with your key pair name
    subnet_id     = aws_subnet.infra_pb_subnet.id
    security_groups = [aws_security_group.infra_sg.name]
    tags = {
        Name = "ec2-user-instance"
    }
}