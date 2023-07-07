FROM maven as build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:8-jdk-alpine
WORKDIR /app
COPY ./target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
