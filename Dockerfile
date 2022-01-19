FROM openjdk:11.0.13-jre
ARG SONAR_VERSION_ARG=9.2.4.50792
ENV SONAR_VERSION=$SONAR_VERSION_ARG \
    SONARQUBE_HOME=/opt/sonarqube \
    SONARQUBE_JDBC_USERNAME=sonar-user \
    SONARQUBE_JDBC_PASSWORD=sonar-password \
    SONARQUBE_JDBC_URL=jdbc:postgresql://sonarqube-db:5432/sonar
EXPOSE 9000
WORKDIR /opt
RUN set -x && \
    apt update && apt install -y bash wget && \
    apt install -y  gnupg unzip && \
    wget -O sonarqube.zip --no-verbose https://binaries.sonarsource.com/CommercialDistribution/sonarqube-enterprise/sonarqube-enterprise-$SONAR_VERSION.zip && \
    unzip sonarqube.zip && \
    mv sonarqube-$SONAR_VERSION sonarqube && \
    chown -R sonarqube:sonarqube sonarqube && \
    rm sonarqube.zip* && \
    rm -rf $SONARQUBE_HOME/bin/*
WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
RUN chmod +x $SONARQUBE_HOME/bin/run.sh
ENTRYPOINT ["./bin/run.sh"]
