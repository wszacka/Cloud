FROM eclipse-temurin:17-jre

WORKDIR /app
COPY target/books-1.0-SNAPSHOT.jar /app/books.jar
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar books.jar"]

#Simple build for your own architecture
#docker build -t markvellaum/springbooks:v0.0.1 -t markvellaum/springbooks:latest .
#docker push markvellaum/springbooks:v0.0.1
#docker push markvellaum/springbooks:latest

#Multiarch build

#docker buildx version
#docker buildx create --name multiarch-builder --use --driver docker-container
#docker buildx inspect --bootstrap
#docker buildx ls

#Note: unless containerd image store is disabled you MUST --push to a remote image registry
#docker buildx build --platform linux/amd64,linux/arm64  -t markvellaum/springbooks:v0.0.1 -t markvellaum/springbooks:latest -f Dockerfile .  --push

#Spring Boot Env variables and default values
#PGHOST=localhost
#PGPORT=5432
#PGDB=books
#PGUSER=myuser
#PGPASS
