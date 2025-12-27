FROM eclipse-temurin:21-jre

WORKDIR /app

COPY simple-java-app-1.0.0.jar app.jar

EXPOSE 9090

CMD ["java", "-jar", "app.jar", "--server.port=9090"]

