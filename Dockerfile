FROM ubuntu:bionic

RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    wget \
    build-essential \
    zip \
    unzip \
    sudo

# Install Default JDK
RUN apt-get -y install default-jdk


# Install node-lts
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -y nodejs

# Install Android SDK

ENV ANDROID_HOME /opt/android-sdk-linux

RUN apt-get update -qq
RUN apt-get install -y openjdk-8-jdk

RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager  --licenses

RUN apt-get clean