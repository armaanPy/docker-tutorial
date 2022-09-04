# Build Jenkins image with .NET Core
# This can be used to install .NET Core into a Jenkins container which you can then run as an independent containerised agent
FROM jenkins/jenkins:lts

# Switch user to root to install .NET Core SDK
USER root

# Show distro information
RUN uname -a && cat /etc/*release

# Based on instructions at https://docs.microsoft.com/en-us/dotnet/core/linux-prerequisites?tabs=netcore2x
# Install dependencies for dotnet core 2
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl libunwind8 gettext apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/dotnetdev.list' && \
    apt-get update

# Install the .NET Core framework, set the path, and show the version of core installed
RUN apt-get install -y dotnet-sdk-2.0.0 && \
    export PATH=$PATH:$HOME/dotnet && \
    dotnet --version

# Switch back to the jenkins user
USER jenkins