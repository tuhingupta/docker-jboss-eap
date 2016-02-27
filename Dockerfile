FROM java:7
MAINTAINER tuhin.gupta@aexp.com
WORKDIR /usr
RUN mkdir software
COPY jboss-eap-6.2.4.zip /usr/software
WORKDIR /usr/software
RUN unzip jboss-eap-6.2.4.zip -d /usr

### Set Environment
ENV JBOSS_HOME /usr/jboss-eap-6.2.4
COPY restapi.war /usr/jboss-eap-6.2.4/standalone/deployments

### Create EAP User
RUN $JBOSS_HOME/bin/add-user.sh admin admin123! --silent

### Configure EAP
RUN echo "JAVA_OPTS=\"\$JAVA_OPTS -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0\"" >> $JBOSS_HOME/bin/standalone.conf

### Open Ports
EXPOSE 8080 9990 9999

WORKDIR /usr/jboss-eap-6.2.4/bin
RUN chmod 755 standalone.sh

ENTRYPOINT $JBOSS_HOME/bin/standalone.sh