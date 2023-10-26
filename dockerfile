# Stage 1: Build stage
FROM maven:3.8.4-openjdk-11-slim AS build-stage

WORKDIR /app

copy ./pom.xml ./pom.xml

copy src ./src

run mvn package

# Stage 2: Production stage
FROM tomcat:8.5.78-jdk11-openjdk-slim

COPY --from=build-stage /app/target/*.war /usr/local/tomcat/webapps/

expose 8080

CMD ["catalina.sh", "run"]
