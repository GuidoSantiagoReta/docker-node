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