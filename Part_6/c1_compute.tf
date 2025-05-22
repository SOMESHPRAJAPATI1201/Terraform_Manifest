

resource "aws_instance" "ec2-user" {
    
    ami           = "ami-0953476d60561c955" # Amazon Linux 2 AMI
    instance_type = "t2.micro"  
    associate_public_ip_address = true
    key_name      = "terraform-somesh-key" # Replace with your key pair name
    subnet_id     = aws_subnet.infra_pb_subnet.id
    security_groups = [aws_security_group.infra_sg.id]

    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install -y postgresql postgresql-contrib",
            "sudo -u postgres psql -c \"CREATE USER tf_user WITH PASSWORD 'tf_pass';\"",
            "sudo -u postgres psql -c \"CREATE DATABASE tf_db OWNER tf_user;\"",
            "echo \"listen_addresses='*'\" | sudo tee -a /etc/postgresql/*/main/postgresql.conf",
            "echo \"host all all 0.0.0.0/0 md5\" | sudo tee -a /etc/postgresql/*/main/pg_hba.conf",
            "sudo systemctl restart postgresql"
        ]

        connection {
            type        = "ssh"
            user        = "ubuntu"
            private_key = file("C:/Users/Dell/Documents/keys_terraform_pem/id_rsa.pem")
            host        = self.public_ip
        }
    }

    tags = {
        Name = "ec2-user-instance"
    }
}