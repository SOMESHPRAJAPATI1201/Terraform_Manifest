output "vpc_id" {
  value = aws_vpc.infra_vpc.id
}

output "ec2_public_ip" {
  value = aws_instance.ec2-user.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.ec2-user.private_ip
}

output "aws_security_group_id" {
  value = aws_security_group.infra_sg.id
}

output "aws_subnet_id" {
  value = aws_subnet.infra_pb_subnet.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.infra_igw.id
}

output "aws_route_table_id" {
  value = aws_route_table.infra_route_table.id
}

output "aws_route_table_association_id" {
  value = aws_route_table_association.infra_route_table_association.id
}