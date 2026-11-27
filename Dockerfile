FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN if [ -d "src - Copy" ]; then mv "src - Copy" src; fi
RUN for i in 1 2 3 4 5; do mvn clean package -DskipTests && break || sleep 60; done
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 10000
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar app.jar"]
