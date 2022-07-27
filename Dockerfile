from ubuntu:20.04

MAINTAINER MAO

RUN apt update && apt dist-upgrade -y

# utiles
RUN apt install -y curl unzip zip software-properties-common less dnsutils wget vim

# install git
RUN apt install -y git

# install java
RUN apt install -y default-jdk

# install mysql-client
RUN apt install -y mysql-client  

# install fish
RUN apt-add-repository ppa:fish-shell/release-3
RUN apt update
RUN apt install -y fish

# install aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# install argocd
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
RUN chmod +x /usr/local/bin/argocd

# install eks
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/local/bin/

# install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN chmod +x /usr/local/bin/kubectl

# install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# add me!
ARG USERNAME=mao
ARG GROUPNAME=mao
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME/

ENTRYPOINT fish