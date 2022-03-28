FROM ubuntu:18.04

# hadolint ignore=DL3008
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bash-completion build-essential tree ack-grep vim libfcgi-perl  \
    zlib1g-dev libfcgi-dev curl ca-certificates zip unzip \
     && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV SDKMAN_DIR=/root/.sdkman

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3003,SC1091
RUN curl -s "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config && \
    echo "sdkman_insecure_ssl=true" >> $SDKMAN_DIR/etc/config && \
    . /root/.sdkman/bin/sdkman-init.sh && \
    sdk install java 22.0.0.2.r17-grl
ENV JAVA_HOME=${SDKMAN_DIR}/candidates/java/current

RUN ${JAVA_HOME}/bin/gu install native-image
ENV PATH=${PATH}:${JAVA_HOME}/bin
