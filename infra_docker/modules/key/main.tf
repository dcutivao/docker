resource "tls_private_key" "generated" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated" {
  key_name   = "aws-key-${var.environment}"
  public_key = tls_private_key.generated.public_key_openssh
}
resource "local_file" "private_key_pem" {
  content   = tls_private_key.generated.private_key_pem
  filename  = "${path.root}/_keys/aws-key-${var.environment}.pem"
  file_permission      = "0600"
}