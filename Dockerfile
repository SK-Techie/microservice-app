# Use Java 17 JRE
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the built jar
COPY app.jar app.jar

# Expose the port your app will run on
EXPOSE 9090

# Pass port as environment variable (optional)
ENV SERVER_PORT=9090

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
