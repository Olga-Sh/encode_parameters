FROM --platform=linux/amd64 keybaseio/client:stable-slim
LABEL maintainer="olga.shalganova@jetbrains.com"

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl jq openjdk-11-jdk-headless && \
    apt-get clean

ARG PARNAS_VERSION=0.2.4

# Add keybase user as keybase cannot be run as root
RUN adduser --disabled-password --gecos "" keybaseme

RUN mkdir -p /opt/ && chown -R keybaseme:keybaseme /opt/

# Add parnas for reading configuration parameters from ssm
RUN curl -L "https://github.com/sndl/parnas/releases/download/v${PARNAS_VERSION}/parnas-${PARNAS_VERSION}.jar" -o /opt/parnas.jar

USER keybaseme

#RUN mkdir -p /opt/ && chown -R keybaseme:keybaseme /opt/

WORKDIR /opt/
