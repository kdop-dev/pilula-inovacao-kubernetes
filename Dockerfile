FROM python:3.7-slim

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y apt-transport-https gnupg2 curl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

RUN mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN pip3 install ipykernel bash_kernel && python3 -m bash_kernel.install