FROM openjdk:17-alpine

COPY target/*.jar /usr/app/application.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/usr/app/application.jar"]