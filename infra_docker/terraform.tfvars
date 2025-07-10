#--------------------------------------Variables-Infraestructura-AWS---------------------------------------------------------
# Eligue la region a deszplegar el servicio:
aws_region = "us-east-1"

# Elige la cantidad de zonas de disponibilidad donde quieres de terner tus subredes:
availability_az = ["us-east-1a", "us-east-1b"]

# Eligue la cantidad de subredes publicas a desplegar teniendo encuenta la disponibilidad de az en la region:
public_subnet_count = 1
# Elige la cantidad de subredes privadas a desplegar teniendo encuenta la disponibilidad de az en la region:
private_subnet_count = 0

# Elige la red global de tu red:
vpc_cidr = "172.16.0.0/16"

# Elige la la cantidad de subredes publicas con su prefijo temiendo encuenta el cird:
public_subnet_cidrs = ["172.16.1.0/24", "172.16.2.0/24"]
# Elige la cantidad de subredes privadas con su prefijo temiendo encuenta el
private_subnet_cidrs = ["172.16.3.0/24", "172.16.4.0/24"]

#---------------------------------------Variables compartidas---------------------------------------------

# Nombre de la instance ec2
name_instance = "server-docker-daco"
# Eleige el entorno el cual quieres desplegar:
environment = "dev"
# Colocar el nombre del propietario de los recursos desplegados:
owner = "Armando"