# Use a lightweight JRE base image
FROM openjdk:17-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file produced by Jenkins
COPY app.jar app.jar

# Create non-root user for security
RUN addgroup --system appgroup && adduser --system appuser --ingroup appgroup
USER appuser

# Configurable application port
ENV PORT=8080
EXPOSE $PORT

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
