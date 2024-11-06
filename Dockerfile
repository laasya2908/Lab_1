# Use an official Maven image to build the application
FROM maven:3.8.1-jdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml .
COPY src /app/src

# Run Maven to build the application (this will download dependencies)
RUN mvn clean install -DskipTests

# Create the final image with the built application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file built in the previous stage
COPY --from=build /app/target/maven-docker-example-1.0-SNAPSHOT.jar /app/app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
