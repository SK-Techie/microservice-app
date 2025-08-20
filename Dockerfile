# Use a lightweight OpenJDK base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the shaded JAR (from workspace root) into the container
COPY *.jar app.jar

# Expose the application port (default: 8080)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
