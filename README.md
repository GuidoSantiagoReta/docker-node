# SERVIDOR NODE + EXPRESS
- Servidor con node y expres escuchando en el puerto 3002

# DOCKERFILE E IMAGEN
- crear dockefile

# CREAR IMAGEN DOCKER 

```
docker build -t your-image-name .

```

# Ejecutar la Aplicación con Docker
## Este comando ejecuta tu imagen Docker, mapeando el puerto 3002 del contenedor al puerto 3002 de tu máquina local.

```
docker run -p 3000:3000 your-image-name
```
![dockerpuerto](https://github.com/GuidoSantiagoReta/docker-node-AWS-EC2/assets/46303885/4bff3d6d-994b-4a25-bdb5-c28c63ae451f)

# Detener el contenedor que está utilizando el puerto:

- listar contenedores en ejecución

```
docker ps
docker stop [CONTAINER_ID]
```
