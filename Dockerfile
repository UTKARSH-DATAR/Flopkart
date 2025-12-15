# Use official Tomcat base image with JDK
FROM tomcat:10.1-jdk21

# Copy your WAR file into Tomcat's ROOT webapp
COPY target/flopkart.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080