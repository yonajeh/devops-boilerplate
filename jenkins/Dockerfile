FROM jenkins/jenkins:lts

USER root

# Update and install Docker CLI from docker.io (Debian repo)
RUN apt-get update
RUN apt-get install -y docker.io
RUN rm -rf /var/lib/apt/lists/*

# Add Jenkins user to the docker group
RUN groupadd -f docker && usermod -aG docker jenkins

USER jenkins
