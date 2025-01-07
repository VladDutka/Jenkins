FROM jenkins/agent:jdk17

USER root

# Update package index and install Python 3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Switch back to the jenkins user
USER jenkins
