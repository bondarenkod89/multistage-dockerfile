FROM maven:3.6.2-jdk-11 AS maven

COPY ./src /APP/src
COPY ./.mvn /APP/.mvn
COPY pom.xml /APP

RUN mvn -f /APP/pom.xml clean package


FROM openjdk:11-jdk

WORKDIR /app

COPY --from=maven /APP/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar ./

EXPOSE 8080
ENTRYPOINT ["java","-jar","./spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar"]
