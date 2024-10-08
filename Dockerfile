FROM eclipse-temurin:21-alpine

# Define el directorio de trabajo
WORKDIR /app

# Instala Maven dentro de la misma imagen
RUN apk add --no-cache maven

# Copia los archivos necesarios para construir el proyecto
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./
COPY src ./src

# Asegúrate de que el script mvnw tenga permisos de ejecución y ejecuta Maven para construir el proyecto
RUN chmod +x mvnw && ./mvnw clean package -Dmaven.test.skip=true && cp target/*.jar /app/app.jar

# Configura el contenedor para la ejecución del JAR
VOLUME /tmp
EXPOSE 8761

# Ejecuta la aplicación
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
