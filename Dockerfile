FROM sonarqube:10.6.0-enterprise
EXPOSE 9000
WORKDIR /opt
WORKDIR $SONARQUBE_HOME
USER root
RUN wget https://file.4sdk.net/sq/sonar-application-10.6.0.92116.jar \
    && rm -rf $SONARQUBE_HOME/lib/sonar-application-10.6.0.92116.jar \
    && mv sonar-application-10.6.0.92116.jar $SONARQUBE_HOME/lib/


USER sonarqube
ENTRYPOINT ["/opt/sonarqube/docker/entrypoint.sh"]
