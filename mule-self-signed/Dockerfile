FROM suprabhatcs/mule-runtime-amc-4.4.0

# Mule installation:
ENV MULE_VERSION=4.4.0
#Add mule runtime in Docker Container
ENV MULE_HOME /opt/mule

#https://developer.mulesoft.com/download-mule-esb-runtime
#ADD mule-ee-distribution-standalone-4.7.1.zip /opt
#ADD test-muleapp.jar /opt

#RUN set -x \
#				&& cd /opt \
#				&& unzip mule-ee-distribution-standalone-4.7.1.zip \
#				&& mv mule-enterprise-standalone-4.7.1 mule \
#				&& $MULE_HOME/bin/mule -installLicense $MULE_HOME/conf/$LICENSE_FILE


WORKDIR $MULE_HOME

# Define mount points
#VOLUME ["/opt/mule/.mule"]

VOLUME $MULE_HOME/apps
VOLUME $MULE_HOME/conf
VOLUME $MULE_HOME/domains
VOLUME $MULE_HOME/logs

# Copy and install license
#CMD echo "------ Copy and install license --------"
#COPY muleLicenseKey.lic $MULE_HOME/conf/
#RUN $MULE_HOME/bin/mule -installLicense $MULE_HOME/conf/muleLicenseKey.lic

#Check if Mule Licence installed
RUN ls -ltr $MULE_HOME/conf/
CMD echo "------ Licence installed ! --------"

#Copy and deploy mule application in runtime
CMD echo "------ Deploying mule application in runtime ! --------"
COPY target/mule-self-signed-1.0.0-SNAPSHOT-mule-application.jar $MULE_HOME/apps/
RUN ls -ltr $MULE_HOME/apps/

# HTTP Service Port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE 8082-8091
EXPOSE 9000
EXPOSE 9082

# Configure external access:
# HTTPS Port for Anypoint Platform communication
EXPOSE  443
# Mule remote debugger
EXPOSE 5000
# Mule JMX port (must match Mule config file)
EXPOSE 1098
# Mule MMC agent port
EXPOSE 7777
# AMC agent port
EXPOSE 9997

# Mule Cluster ports
EXPOSE 5701
EXPOSE 54327
# HTTP Service Port
EXPOSE 8081
# HTTPS Service Port
EXPOSE 8091
# Start Mule runtime

# Start Mule runtime
CMD echo "------ Start Mule runtime --------"
ENTRYPOINT ["./bin/mule"]

# Environment and execution:
CMD ["/opt/mule/bin/mule", "-M-Dmule.agent.enabled=false"]
