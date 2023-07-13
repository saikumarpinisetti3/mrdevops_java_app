FROM maven:3.8.3 as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:8-jdk-alpine3.9
WORKDIR /app
COPY --from=build /app/target/kubernetes-configmap-reload-0.0.1.jar /app/
EXPOSE 9099
CMD ["java", "-jar", "/app/kubernetes-configmap-reload-0.0.1.jar"]

