FROM openjdk:17-jdk-slim

# Set the working directory in the final image
WORKDIR /app

# Copy the Spring Boot application JAR file from the build stage
COPY  target/*.jar /app/app.jar

# Expose port 8080 for the web application
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]