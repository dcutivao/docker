output "ip_public_instace" {
  value = aws_instance.ec2[var.name_instance].public_ip
}