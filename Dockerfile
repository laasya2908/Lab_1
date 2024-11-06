# Use Maven image to build the application
FROM maven:3.8.6-openjdk-11 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package

# Use a smaller image for runtime
FROM openjdk:11-jre-slim

# Copy the jar file from the build stage
COPY --from=build /app/target/maven-docker-example-1.0-SNAPSHOT.jar /usr/local/lib/my-app.jar

# Command to run the application
ENTRYPOINT ["java", "-jar", "/usr/local/lib/my-app.jar"]
