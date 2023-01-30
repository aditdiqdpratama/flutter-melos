FROM ubuntu:latest

# install base dependency
RUN apt-get update
RUN apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa

RUN groupadd -r -g 1441 docker && useradd --no-log-init -r -u 1441 -g docker -m flutter_usr

USER flutter_usr:docker
WORKDIR /home/flutter_usr

# install flutter
RUN git clone https://github.com/flutter/flutter.git -b 2.8.1 
# add flutter path
ENV PATH="$PATH":"/home/flutter_usr/flutter/bin"

RUN flutter doctor

# install melos
RUN dart pub global activate melos
ENV PATH="$PATH":"/home/flutter_usr/.pub-cache/bin"
ENV MELOS_SDK_PATH="/home/flutter_usr/flutter"
