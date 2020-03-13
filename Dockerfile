FROM ubuntu:bionic

RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    wget \
    build-essential \
    zip \
    unzip \
    sudo

# Install node-lts
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -y nodejs

# Install Default JDK
RUN apt-get install -y openjdk-8-jdk

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk-linux

RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# RUN touch /root/.android/repositories.cfg
RUN yes | sdkmanager --update --channel=3
RUN sdkmanager "tools" "platform-tools"

RUN yes | sdkmanager \
    "platforms;android-29" \
    "build-tools;29.0.2" \
    "build-tools;29.0.1" \
    "build-tools;29.0.0" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services"

RUN apt-get -y install gradle && gradle -v

RUN yes | sdkmanager  --licenses

RUN sdkmanager --install "ndk;20.0.5594570"

RUN apt-get clean

COPY entrypoint.sh /
ENTRYPOINT [ "./entrypoint.sh" ]
