# Use the official Maven image to build the application
FROM maven:3.9.0-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .

# Download the Maven dependencies (helps in caching dependencies layer)
RUN mvn dependency:go-offline

# Copy the rest of the application source code to the container
COPY src ./src

# Package the application (Spring Boot JAR file) using Maven
RUN mvn clean package -DskipTests

# Use a smaller JRE image for the final runtime environment
FROM openjdk:17-jdk-slim

# Set the working directory in the final image
WORKDIR /app

# Copy the Spring Boot application JAR file from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Expose port 8080 for the web application
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]