# Use an official Maven image to build the application
FROM maven:3.8.1-jdk-11-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and download dependencies to leverage Docker cache
COPY pom.xml /app/

# Download Maven dependencies (this helps speed up future builds)
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY . /app/

# Build the app (skip tests for now to save time)
RUN mvn clean install -DskipTests

# Now that the app is built, we need a runtime environment
# Use OpenJDK base image for the runtime
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built artifacts (usually found in target/) from the build image
COPY --from=build /app/target /app/target

# Expose the port the application will run on (adjust if necessary)
EXPOSE 8080

# Command to run the app (replace with your actual command to run the app)
CMD ["java", "-jar", "/app/target/your-app.jar"]

