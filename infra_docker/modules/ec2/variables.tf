variable "instances" {
  description = "Lista de instancias a crear"
  type = map(object({
    instance_type        = string
    subnet_id            = string
    os                   = string
    security_groups      = list(string)
    #iam_instance_profile = string
    key_name             = string
  }))
}

variable "aws_region" {
  description = "Región donde se lanzarán las instancias"
  type        = string
}

variable "amis" {
  description = "Mapa de AMIs por región y sistema operativo"
  type        = map(map(string))
}

variable "environment" {
  description = "Nombre del entorno (ejemplo: dev, staging, prod)"
  type        = string
}

variable "output_private_key" {
  description = "Nombre del archivo de clave privada para el acceso SSH"
  type = string
}

variable "name_instance" {
  description = "Nombre de la instancia"
  type        = string
}