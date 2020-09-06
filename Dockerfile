FROM jupyter/scipy-notebook:6d42503c684f

USER root

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y apt-transport-https gnupg2 curl wget

# Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# kubectl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

RUN mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

# helm
RUN wget -c "https://get.helm.sh/helm-v3.3.1-linux-amd64.tar.gz" -O - | tar -xz && mv linux-amd64/helm /usr/local/bin/helm && chmod +x /usr/local/bin/helm && rm -rf linux-amd64

# install the notebook package
RUN pip install --no-cache --upgrade pip

RUN pip install --no-cache-dir notebook==6.*

RUN pip3 install ipykernel bash_kernel && python3 -m bash_kernel.install

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

#RUN adduser --disabled-password \
#    --gecos "Default user" \
#    --uid ${NB_UID} \
#    ${NB_USER}

WORKDIR ${HOME}
USER ${USER}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
