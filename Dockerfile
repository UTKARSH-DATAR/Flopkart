# Stage 1: Build with Maven
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:10.1-jdk21
COPY --from=build /app/target/flopkart.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080