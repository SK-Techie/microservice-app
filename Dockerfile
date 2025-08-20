# Use a lightweight OpenJDK base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the fat JAR (built by Maven) into the container
COPY target/*.jar app.jar

# Expose the application port (default: 8080)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
