# Stage 1: Build
FROM maven:3.8.6-openjdk-17 AS build  # Change this line if necessary

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot application code into the container
COPY . .

# Build the application using Maven
RUN mvn clean install

# Stage 2: Run
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from the build stage to the run stage
COPY --from=build /app/target/your-application-name.jar app.jar

# Expose the application port (default Spring Boot port)
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
