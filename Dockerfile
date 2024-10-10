FROM oraclelinux:8.4 AS WarfileBuilder 
LABEL name=uday
RUN dnf install java-1.8.0-openjdk.x86_64  java-1.8.0-openjdk-devel.x86_64  maven git -y 
RUN mkdir /uday-java
WORKDIR /uday-java

COPY . .
# now running maven to create .war file 
RUN mvn clean package

FROM tomcat 
LABEL email="udaysrivastava0@gmail.com"
COPY --from=WarfileBuilder /uday-java/java-springboot/target/WebApp.war /usr/local/tomcat/webapps/
