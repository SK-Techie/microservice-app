# Use a lightweight OpenJDK runtime base image
FROM openjdk:17-jre-slim-bullseye

# Set the working directory
WORKDIR /app

# Copy the JAR file produced by Jenkins
COPY app.jar app.jar

# Expose the application port (default: 8080)
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
