FROM ubuntu:18.04

# hadolint ignore=DL3008
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bash-completion build-essential vim libfcgi-perl  \
    zlib1g-dev libfcgi-dev curl ca-certificates zip unzip wget tree \
     && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG DOWNLOAD_URL=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.2.0/graalvm-ce-java17-linux-amd64-22.2.0.tar.gz

ENV GRAALVM_DIR=/usr/local/graalvm

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003,SC1091
RUN wget --progress=dot:giga "${DOWNLOAD_URL}" \
    && mkdir -p ${GRAALVM_DIR} \
    && cd "${GRAALVM_DIR}" \
    && tar -x -z --strip-components=1 -f /graalvm*.tar.gz \
    && rm /graalvm*.tar.gz

ENV JAVA_HOME=${GRAALVM_DIR}

RUN ${JAVA_HOME}/bin/gu install native-image
ENV PATH=${PATH}:${JAVA_HOME}/bin
