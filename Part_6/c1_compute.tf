

resource "aws_instance" "ec2-user" {
    
    ami           = "ami-084568db4383264d4" # Ubuntu Server 20.04 LTS
    instance_type = "t2.micro"  
    associate_public_ip_address = true
    key_name      = "terraform-somesh-key" # Replace with your key pair name
    subnet_id     = aws_subnet.infra_pb_subnet.id
    security_groups = [aws_security_group.infra_sg.id]
    tags = {
        Name = "ubuntu-ec2-instance"
    }
}