
output "public_instance_ip" {
    description = "Public IP address of the PB Compute instance"
    value       = aws_instance.pb_compute_instance.public_ip
}

output "private_instance_ip" {
    description = "Private IP address of the PV Compute instance"
    value       = aws_instance.pv_compute_instance.private_ip
}