FROM gocd/gocd-agent:16.12.0
MAINTAINER Kenny Casagrande kbcasagrande@gmail.com
RUN apt-get update \
    && apt-get install -y \
       apt-transport-https \
       ca-certificates \
       python-pip \
       python-openssl \
    && apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo "deb https://apt.dockerproject.org/repo ubuntu-precise main" | sudo tee /etc/apt/sources.list.d/docker.list
RUN apt-get update \
    && apt-get install -y docker-engine \
    && apt-get clean \
    && pip install docker-compose \
    && pip install --upgrade pip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY go.sudoers /etc/sudoers.d/go
COPY go-agent /etc/default/go-agent
COPY agent.sh /usr/share/go-agent/agent.sh
RUN echo "StrictHostKeyChecking no"     >> /etc/ssh/ssh_config \
 && echo "UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config 
