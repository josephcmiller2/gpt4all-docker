#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
#FROM ubuntu:22.04
FROM nvidia/cuda:11.7.0-base-ubuntu22.04

RUN \
  mkdir /shared && \
  apt-get update && \
  apt-get install -y gnupg wget software-properties-common

RUN \
  apt-get install -y snapd pulseaudio

ENV TZ=America/Denver
ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y git python3 python3-opencv python3-pip

RUN \
  apt-get install -y libglvnd0 libgl1 libglx0 libegl1 libxext6 libx11-6

RUN \
  apt-get install -y vim podman uidmap rsyslog

RUN \
  cd /root && git clone https://github.com/Torantulino/Auto-GPT.git && \
  cd /root/Auto-GPT && pip install -r requirements.txt

RUN \
  apt-get install -y screen

COPY files/startcontainer.sh /usr/bin/startcontainer.sh
COPY files/subuid /etc/subuid
COPY files/subgid /etc/subgid
COPY files/registries.conf /etc/containers/registries.conf

# Set environment variables
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute
ENV HOME /root

# Define working directory.
WORKDIR /root/Auto-GPT

# Define default command.
CMD ["bash"]
