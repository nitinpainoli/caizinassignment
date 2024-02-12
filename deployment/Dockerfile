FROM  openjdk
WORKDIR /app
COPY . .
RUN ./mvnw package
EXPOSE 8080
CMD ["java", "-jar", "target/*.jar"]