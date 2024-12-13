# Stage 1: Build
FROM maven:3.8.6-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files into the container
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY src /app/src

# Build the application using Maven
RUN mvn clean install

# Stage 2: Run
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the 'build' stage
COPY --from=build /app/target/your-application-name.jar app.jar

# Expose the port for the Spring Boot application
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
