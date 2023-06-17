FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
WORKDIR /usr/src/app

COPY ./ ./backend/
RUN cd backend && mvn install

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE Intelligent-Tutoring-System/target/IntelligentTutorSystem-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar

EXPOSE 8080
CMD ["catalina.sh", "run"]


