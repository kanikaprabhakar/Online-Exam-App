# Multi-stage build for Spring Boot WAR
FROM maven:3.9.9-eclipse-temurin-11 AS build
WORKDIR /app

COPY pom.xml ./
COPY src ./src
RUN mvn -q -DskipTests clean package

FROM eclipse-temurin:11-jre
WORKDIR /app

COPY --from=build /app/target/OnlineExamApp2-0.0.1-SNAPSHOT.war /app/app.war

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -Dserver.port=${PORT:-8080} -jar /app/app.war"]
