FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM  openjdk:11.0
WORKDIR /app
COPY --from=build /app/target/kubernetes-configmap-reload-0.0.1.jar /app/
EXPOSE 9099
CMD ["java", "-jar", "/app/kubernetes-configmap-reload-0.0.1.jar"]

