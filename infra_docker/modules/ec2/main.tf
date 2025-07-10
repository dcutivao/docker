resource "aws_instance" "ec2" {
  for_each               = var.instances
  ami                    = var.amis[var.aws_region][each.value.os]
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.security_groups
  #iam_instance_profile   = each.value.iam_instance_profile
  key_name               = each.value.key_name
  
  # Bloque de conexion con la instancia le dira como conectarce a esta EC2 
  connection {
    user        = "ubuntu"
    private_key = var.output_private_key
    host        = self.public_ip # Usaremos la ip publica de la propia instancia para conectarnos a ella
  }

  provisioner "remote-exec" {
    inline = [ 
      <<-EOF
        sudo apt-get update
        sudo apt-get install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo systemctl enable docker
        grupoadd docker
        useradd usuario_docker
        sudo usermod -aG docker usuario_docker
        sudo docker run hello-world
      EOF
     ]
  }
  tags = {
    "Name"        = each.key
    "server"      = each.key
    "environment" = var.environment
    "Terraform"   = "true"
  }
}