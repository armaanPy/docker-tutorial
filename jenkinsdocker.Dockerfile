# Build a Jenkins base image and install Docker on it, this can be used as a containerised agent for Jenkins
# https://github.com/microsoft/WSL/discussions/4872?sort=top - Error initalising network controller

FROM jenkins/jenkins:lts

USER root

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    lxc \
    iptables

RUN update-alternatives --set iptables /usr/sbin/iptables-legacy

# Install Docker via Linux installation script
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh

# Add jenkins user to docker group
RUN usermod -aG docker jenkins

CMD dockerd