FROM eclipse-temurin:17-jre
WORKDIR /app
COPY app.jar app.jar
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "app.jar"]

