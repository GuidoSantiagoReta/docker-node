# imagen oficial de Node.js como base
FROM node:lts-alpine3.18

# Crear un directorio en el contenedor para la aplicación
RUN mkdir -p /opt/app

# Establecer el directorio de trabajo en el contenedor
WORKDIR /opt/app

# Copia los archivos package.json y package-lock.json al contenedor
COPY package.json package-lock.json ./

# Instalar las dependencias de la aplicación
RUN npm install

# Copiar el resto de los archivos de la aplicación al contenedor
COPY . .

# Exponer el puerto 3002 para que la aplicación sea accesible
EXPOSE 3002

# Comando para iniciar la aplicación
CMD ["node", "app.js"]
