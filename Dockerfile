FROM ubuntu:latest

ARG PARNAS_VERSION=0.1.9

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        jq \ 
        openjdk-8-jdk-headless && \
    apt-get clean

RUN curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
RUN apt install -y ./keybase_amd64.deb

# Add parnas for reading configuration parameters from ssm
RUN curl -L "https://github.com/sndl/parnas/releases/download/v${PARNAS_VERSION}/parnas-${PARNAS_VERSION}.jar" -o /opt/parnas.jar

# Add keybase user as keybase cannot be run as root
RUN adduser --disabled-password --gecos "" keybaseme
USER keybaseme

WORKDIR /opt/

RUN run_keybase
