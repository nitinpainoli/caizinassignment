FROM openjdk:17-jdk-slim

RUN apt-get update && apt-get install -y maven

WORKDIR /app

COPY . .

RUN ./mvnw generate-resources

RUN ./mvnw package

CMD ["java", "-jar", "target/spring-petclinic-3.2.0-SNAPSHOT.jar"]
