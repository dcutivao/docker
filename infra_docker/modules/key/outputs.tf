output "aws_key_pair" {
  value = aws_key_pair.generated.key_name
}

output "output_private_key" {
  value = tls_private_key.generated.private_key_pem
}