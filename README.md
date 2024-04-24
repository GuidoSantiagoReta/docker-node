## SERVIDOR NODE + EXPRESS
- Servidor con node y expres escuchando en el puerto 3002

## DOCKERFILE E IMAGEN
- crear dockerfile

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

# PARA REALIZAR LO DE DOCKER, TERRAFORMY EC2 ( ACORDARSE QUE YA ESTA LA IMAGEN CREADA dockernode corriendo en el puerto 3002 y subida a dockerhub)

## Para cumplir con los requisitos de tu tarea, necesitarás seguir una serie de pasos que involucran la configuración de GitHub Actions para automatizar el proceso de CI/CD, incluyendo la generación de una imagen Docker, su subida a DockerHub, y el despliegue manual en tu instancia EC2. Aquí te dejo una guía paso a paso: seguir pasos 

1. Generar un PAT (Personal Access Token) en GitHub
Ve a la configuración de tu cuenta de GitHub.
Navega a "Developer settings" > "Personal access tokens".
Genera un nuevo token con los permisos necesarios para acceder a tu repositorio y realizar operaciones de escritura.
Guarda este token en un lugar seguro, ya que lo necesitarás para configurar GitHub Actions.
2. Configurar el PAT como un Secret en GitHub
En tu repositorio de GitHub, ve a "Settings" > "Secrets".
Crea un nuevo secret, por ejemplo, GH_PAT, y pega el token que generaste en el paso anterior.
3. Crear el CI Pipeline con GitHub Actions
Para crear el CI Pipeline, necesitarás definir un archivo de workflow en tu repositorio. Este archivo debe estar ubicado en 
.github/workflows/. 

```
name: CI/CD Pipeline

on:
 push:
    branches: [ main ]

jobs:
 build-and-push:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Login to DockerHub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_TOKEN }}

    - name: Build and push Docker image
      uses: docker/build-push-action@v2
      with:
        context: .
        push: true
        tags: your-dockerhub-username/your-repo-name:latest

 deploy:
    runs-on: ubuntu-latest
    needs: build-and-push
    steps:
    - name: SSH into EC2 instance
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ${{ secrets.EC2_USERNAME }}
        key: ${{ secrets.EC2_SSH_KEY }}
        script: |
          sudo apt-get update
          sudo apt-get install -y docker.io
          docker pull your-dockerhub-username/your-repo-name:latest
          docker run -d -p 80:80 your-dockerhub-username/your-repo-name:latest
```
## Este workflow se activa cada vez que se realiza un push a la rama main. Primero, construye y sube la imagen Docker a DockerHub. Luego, se conecta a tu instancia EC2 a través de SSH para instalar Docker (si aún no está instalado) y ejecutar la imagen Docker que acabas de subir.

4. Configurar los Secrets en GitHub
En tu repositorio de GitHub, ve a "Settings" > "Secrets".
Crea los siguientes secrets:
DOCKERHUB_USERNAME: Tu nombre de usuario de DockerHub.
DOCKERHUB_TOKEN: Tu token de acceso de DockerHub.
EC2_HOST: La dirección IP pública de tu instancia EC2.
EC2_USERNAME: El nombre de usuario para acceder a tu instancia EC2 (por ejemplo, ubuntu).
EC2_SSH_KEY: La clave privada SSH para acceder a tu instancia EC2.

5. Despliegue Manual
Para asegurar que el despliegue sea manual, puedes configurar el workflow para que se ejecute solo cuando se activa manualmente. Esto se puede hacer utilizando el evento workflow_dispatch en lugar de push en la sección on de tu archivo de workflow.

