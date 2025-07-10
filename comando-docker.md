# Validación estado servicio docker

systemctl enable docker        # cada vez que arrnaque el sistema operativo, se ejecutará el servicio de docker
systemctl start docker         # arranca el servicio de docker
systemctl status docker        # muestra el estado del servicio de docker
docker version                 #
dockerd                        # ejecuta el servicio de docker a mano
ps -ef | grep docker           # le indicamos a nuestro linux que muestre los procesos de docker

# usuario para trabajar con docker y no estar trabajando con el usuario root
grupoadd docker                          # crea un grupo llamado docker en nuestro linux
cat /etc/group                           # muestra los grupos existentes en nuestro linux
useradd usuario_docker                   # crea un usuario llamado usuario_docker en nuestro linux
passwd usuario_docker                    # le asignamos una contraseña al usuario
sudo usermod -aG docker usuario_docker   # agrega al grupo docker el usuario usuario_docker

# Docker hub
  - Si guieres subir imagen recurda la nomenclatura usuario/nombre de la imagen ejmeplo : usuario/imagen

# comandos de docker
docker run imagen                             # si no se tiene la imagen en local la descarga de docker hub y crea el container. si ejecutamos el comando varias veces se crean varios contenedores.
docker pull imagen                            # descarga la imagen de docker hub
docker images                                 # nos muestra las imagenes que tenemos en nuestro docker a nivel local
docker ps                                     # nos muestra los contenedores que tenemos en ejecución
docker ps -a                                  # muestra todos los contenedores que se encuentran en stop o parados
docker ps -l                                  # nos lista el ultimo contenedor el cual emos trabajado
docker ps -q                                  # muestra el id de los contenedores que se encuentran en ejecución
docker stop id_contenedor                     # para el contenedor con el id que le pasamos
docker rm id_contenedor                       # elimina el contenedor con el id que le pasamos
docker rmi id_imagen                          # elimina la imagen con el id que le pasamos
docker ps -a -n 3 -s                          # muestra los 3 contenedores que se encuentran en stop o parados y el -s nos muestra el tamaño de cada contenedor
docker ps -a -f "name=nombrecontenedor"       # sacara el nombre de los contenedores que cumplan la el filtro
docker run --name nombre_contenedor imagen    # ejecuta el contenedor con el nombre que le pasamos
docker run --name ubuntu1 -it ubuntu bash     # ejecuta el contenedor con el nombre que le pasamos y nos permite interactuar con el contenedor en su terminal tty
docker start -i id_contenedor el nombre       # arranca el contenedor con el id que le pasamos o el nombre y nos permite interactuar con el contenedor en su terminal tty
docker run --name ubuntu2 -d -it ubuntu       # corre el contenedor en background y de forma interactiva
docker run --name nginx -d nginx:stable-perl  # corre con la inagen de la etiqueta stable-perl
docker rm 4780                                # elimina el contenedor con el id 4780 solo necesitamos los primeros 4 caracteres del conetenedor o con el nombre del contenedor.
docker rmi 8589                               # elimina la imagen con el id 4780
docker rmi -f 8589                            # elimina la imagen con el id 4789 de modo forzado
docker exec name_contenedor comando           # ejecuta el comando en el contenedor name_contenedor y nos devuelve el resultado del contenedor
docker exec -it name_contenedor bash          # permite entrar dentro del contenedor
docker attach name_contenedo                  # tambien ingresa al contenedor
docker attach name_contenedo top              # nos muestra el top directamente del contenedor
docker run -d ubuntu ssh -c "while true; do date; done"           # correr un proceso en el docker
docker logs 3076b                             # nos indica los logs del contenedor 
docker logs 3076b --tail 10                   # nos mostrara los ultimos 10 logs del container
docker kill container_id                      # matar un container
docker top container_id                       # nos muestra los procesos del contenedor
docker stats container_id                     # usos de recursos
docker inspect container_id                   # caracteristicas del contenedor, informacion del contenedro
docker inspect image_id                       # informacion de la imagen podemos enviarlo a un archivo y verlo con un editor como vim
docker system                                 # nos da informacion como tal donde tenemos montado nuestro docker agregando df, event, info o prune(tener cuidado borrara todo los contenedores, red imagenes y cache que no este utilizada)
docker cp prueba.txt contenedor_id:/tmp       # copiar un archivo desde el server docker a un container
docker cp file.txt contenedor_id:/tmp .       # copiar archivo alojado en el contenedor enviado a sevidor docker
docker stop $(docker ps -q)                   # se detienen todos los contenedores y el -q nos muestra el id de los contenedores que se detubieron

# variables en docker
docker run --name ubuntu1 -d -it -e key=value ubuntu                                       # con el -e indicamos que es una variable anexamos la llave=valor pasar los en mayuscula(opcional) validar la varible en el contenedor comando env 
docker run --name ubuntu1 -d -it -e key=value -e key=value ubuntu                          # podemos pasar tantas variables como se requieran
docker run --detach --name some-mariadb --env MARIADB_ROOT_PASSWORD=my-secret-pw  mariadb  # variable requerida para corre el contenedor mariadb podemos pasar la variables en un archivo ejemplo: --env-file archivo

# Redes en docker
docker network ls                                          # redes predefinidas en el server_dcoker y contenedores
docker network inspect bridge                              # archivo inspect de la red bridge          
docker run --name apache-daco -d -p 9000:80 httpd          # indicamos que el contenedor puede ser accedido medinate el puerto 9000 y lo redirecciona al -> 80     server_docker=9000  contenedor=80
docker run --name nginx-daco_8080 -d -P nginx              # con el -P mayuscula genera un puerto alatorio para nuestro contenedor nginx  
docker inspect apache-daco | grep -i IPadd                 # inspeccionar ip asiganada al contenedor 

# Trabajar con container windows
    * Windows for desktop windows
    * Se tiene que swichar o decirle a docker que trabaje con las libreias de windows solo se puede en windows ya que trabaja con WSL2 no sirve para el server linux.
    * Tener encuenta la version y la compilación del sistema operativo windows.
    * podemos integrar docker destop windows con WSL2 en los recurso de docker desktop y activar la distribución que tengamos(ubuntu) en WSL2 y ya podemos trabajar en la distribucion con docker serve.
    * poedmos desplegar container windows y linux si sepuede pero debemos activar primero punto anteriir antes de swichar para tarbajr con contenedores windows deplegar container linux ingresar a WSL2 y windows viseversa  

# comandos windows: 
docker pull mcr.microsoft.com/windows/nanoserver:20H2   # descarga la imagen tener encuenta la etiqueta(tag)
docker exec -it nombre_contenedor cmd                   # ingresa al cmd del contenedor  
