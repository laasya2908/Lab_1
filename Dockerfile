# Use Maven image to build the app
FROM maven:3.8.1-jdk-11-slim AS build

# Set working directory
WORKDIR /app

# Copy the source code and pom file
COPY . /app

# Build the app with Maven (skip tests for now)
RUN mvn clean install -DskipTests

# Use OpenJDK for the runtime environment
FROM openjdk:11-jre-slim

# Set working directory for the final image
WORKDIR /app

# Copy the built JAR from the Maven build stage
COPY --from=build /app/target/maven-docker-example-1.0-SNAPSHOT.jar /app/app.jar

# Run the JAR file as the entry point
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# Expose any necessary port (if needed)
EXPOSE 8080
