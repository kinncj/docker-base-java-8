FROM ubuntu:zesty

MAINTAINER Kinn Coelho Juliao <kinncj@php.net>

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common python-software-properties apt-utils curl unzip
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:webupd8team/java
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

ENV GRADLE_VERSION 3.3
ENV GRADLE_SHA c58650c278d8cf0696cab65108ae3c8d95eea9c1938e0eb8b997095d5ca9a292

RUN cd /usr/lib \
    && curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
    && echo "$GRADLE_SHA gradle-bin.zip" | sha256sum -c - \
    && unzip "gradle-bin.zip" \
    && ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
    && rm "gradle-bin.zip"

ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

WORKDIR /opt
