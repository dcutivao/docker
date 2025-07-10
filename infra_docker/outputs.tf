output "conect_instance" {
  value = "ssh -i 'aws-key-dev.pem' ubuntu@${module.ec2.ip_public_instace}"
}

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}