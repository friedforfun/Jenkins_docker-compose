FROM jenkins/jenkins:lts
USER root
COPY run.sh ./run.sh
RUN chmod +x ./run.sh

RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-19.03.3.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download
# groupadd -g 999 docker && \
# usermod -aG docker jenkins &&\
# gpasswd -a jenkins docker

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

#USER jenkins

ENTRYPOINT ["/bin/bash","-c","./run.sh"]