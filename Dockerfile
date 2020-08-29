FROM jupyter/minimal-notebook

USER root

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y apt-transport-https gnupg2 curl

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

RUN mv kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

RUN pip3 install ipykernel bash_kernel && python3 -m bash_kernel.install
