FROM maven:3.8.6-openjdk-11 AS build
RUN git clone https://github.com/vriusc/Intelligent-Tutoring-System.git
RUN cd Intelligent-Tutoring-System && git checkout Back_End && mvn install
#ENTRYPOINT ["tail", "-f", "/dev/null"]
#FROM tomcat:9-jre11

#RUN rm -rf /usr/local/tomcat/webapps/*

#COPY --from=build Intelligent-Tutoring-System/target/demo1-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar

#EXPOSE 8080
#CMD ["catalina.sh", "run"]
EXPOSE 8080
CMD ["java", "-jar","Intelligent-Tutoring-System/target/demo1-0.0.1-SNAPSHOT.jar"]
