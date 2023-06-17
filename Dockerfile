FROM openjdk:11 AS BUILD_IMAGE
ENTRYPOINT ["tail", "-f", "/dev/null"]
RUN apt-get update && apt-get install -y maven
#WORKDIR /root
RUN git clone https://github.com/vriusc/Intelligent-Tutoring-System.git
RUN cd Intelligent-Tutoring-System && git checkout Back---End && mvn install

FROM tomcat:9-jre11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=BUILD_IMAGE Intelligent-Tutoring-System/target/IntelligentTutorSystem-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar
EXPOSE 8080
CMD ["catalina.sh", "run"]

