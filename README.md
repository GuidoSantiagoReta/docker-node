## SERVIDOR NODE + EXPRESS
- Servidor con node y expres escuchando en el puerto 3002

## DOCKERFILE E IMAGEN
- crear dockefile

## CREAR IMAGEN DOCKER 

```
docker build -t your-image-name .

```

## Ejecutar la Aplicación con Docker
- Este comando ejecuta tu imagen Docker, mapeando el puerto 3002 del contenedor al puerto 3002 de tu máquina local.

```
docker run -p 3002:3002 your-image-name
```

## Detener el contenedor que está utilizando el puerto:

- listar contenedores en ejecución

```
docker ps
docker stop [CONTAINER_ID]

```

## Subir la Imagen a un Repositorio Docker Hub
Si deseas compartir tu imagen Docker o desplegarla en un entorno de producción, Aquí tienes cómo hacerlo para Docker Hub:

```
docker login
docker tag your-image-name your-dockerhub-username/your-image-name
docker push your-dockerhub-username/your-image-name
```
Reemplaza your-dockerhub-username/your-image-name con tu nombre de usuario de Docker Hub y el nombre de tu imagen.

## CONEXIÓN CON LA INSTANCIA EC2: 
- Para ejecutar docker run y docker pull en una instancia EC2 usando GitHub Actions, puedes seguir estos pasos basados en la información proporcionada y las prácticas recomendadas:

Configura las credenciales de AWS en GitHub Actions: Utiliza la acción aws-actions/configure-aws-credentials para configurar las credenciales de AWS en tu flujo de trabajo de GitHub Actions. Esto te permitirá interactuar con los servicios de AWS, incluyendo EC2 y ECR (si estás utilizando imágenes Docker almacenadas en ECR).
Instala Docker en la instancia EC2: Si tu instancia EC2 no tiene Docker instalado, necesitarás instalarlo. Esto se puede hacer mediante el script de user_data en tu configuración de Terraform para la instancia EC2. Aquí tienes un ejemplo de cómo hacerlo:

```
resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c574c8" # Asegúrate de usar la AMI correcta para tu región
  instance_type = "t2.micro"

  user_data = <<-EOF
             #!/bin/bash
             sudo yum update -y
             sudo yum install -y docker
             sudo service docker start
             sudo usermod -a -G docker ec2-user
             EOF
}
```
Ejecuta comandos Docker a través de SSH: Para ejecutar comandos Docker en la instancia EC2 desde GitHub Actions, puedes utilizar la acción appleboy/ssh-action. Esta acción te permite ejecutar comandos en una instancia EC2 a través de SSH. Aquí tienes un ejemplo de cómo configurar esta acción en tu flujo de trabajo de GitHub Actions:

```
- name: Execute Docker commands
  uses: appleboy/ssh-action@master
  with:
    host: ${{ secrets.EC2_PUBLIC_IP }}
    username: ec2-user
    key: ${{ secrets.EC2_SSH_KEY }}
    script: |
      docker pull your-image-name
      docker run -d -p 80:80 your-image-name

```
Asegúrate de reemplazar your-image-name con el nombre de tu imagen Docker y de configurar las variables de secreto EC2_PUBLIC_IP y EC2_SSH_KEY en tu repositorio de GitHub con la IP pública de tu instancia EC2 y la clave SSH privada correspondiente.

Manejo de IPs dinámicas: Si la IP de tu instancia EC2 cambia con frecuencia (por ejemplo, si se destruye y recrea), considera utilizar un servicio de DNS dinámico o un balanceador de carga para manejar las conexiones a tu instancia.
Recuerda que este proceso implica exponer tu clave SSH en GitHub Actions, lo cual puede tener implicaciones de seguridad. Asegúrate de seguir las mejores prácticas de seguridad, como el uso de claves SSH sin contraseña y la limitación del acceso a la instancia EC2 solo a las acciones de GitHub Actions.

Este enfoque combina la configuración de Terraform para la creación de la instancia EC2, la configuración de GitHub Actions para la ejecución de comandos Docker a través de SSH, y el manejo de credenciales de AWS para la autenticación con los servicios de AWS.