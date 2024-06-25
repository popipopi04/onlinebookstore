# Use the official Tomcat image from Docker Hub
FROM tomcat:latest

# Copy the WAR file into the webapps directory of Tomcat
COPY ./target/*.war /usr/local/tomcat/webapps/
# Copy context.xml for host-manager application
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/

# Copy tomcat-users.xml for configuring users
COPY tomcat-users.xml /usr/local/tomcat/conf/

# Expose port 8080 to allow outside access to Tomcat
EXPOSE 8080
CMD ["catalina.sh", "run"]
