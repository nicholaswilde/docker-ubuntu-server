ARG VERSION
FROM ubuntu:${VERSION}
ARG BUILD_DATE
ARG UBUNTU_USER
ARG UBUNTU_PASSWORD
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
ENV DEBIAN_FRONTEND noninteractive
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    ubuntu-server=1.487 \
    sudo=1.9.9-1ubuntu2 \
    tzdata=2022a-0ubuntu1 && \
  echo "**** add user ****" && \
  adduser "${UBUNTU_USER}" && \
  echo "${UBUNTU_USER}:${UBUNTU_PASSWORD}" | chpasswd && \
  usermod -aG sudo "${UBUNTU_USER}" && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/ \
    /var/tmp/*
