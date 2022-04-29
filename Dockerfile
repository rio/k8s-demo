FROM docker.io/library/ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&  \
    apt-get -y install --no-install-recommends \
    vim \
    ca-certificates \
    curl

SHELL [ "/bin/bash", "-c" ]

# install kubectl
RUN curl -sfSLO https://dl.k8s.io/release/v1.23.4/bin/linux/amd64/kubectl && \
    sha256sum -c - <<<"3f0398d4c8a5ff633e09abd0764ed3b9091fafbe3044970108794b02731c72d6  kubectl" && \
    chmod +x kubectl && \
    mv -v kubectl /usr/local/bin

# install k3d
RUN curl -sfSLO https://github.com/k3d-io/k3d/releases/download/v5.3.0/k3d-linux-amd64 && \
    sha256sum -c - <<<"b609bf296acb0f0fa5c79f2ff4bdd5901b385833cf469ac503468989e64eb01c  k3d-linux-amd64" && \
    chmod +x k3d-linux-amd64 && \
    mv -v k3d-linux-amd64 /usr/local/bin/k3d

# install k9s
RUN curl -sfSLo- https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz | gzip -d | tar xf - k9s && \
    sha256sum -c - <<<"eabb69c297a459f85e530ae84d682f2be321c1b7c607aa6d5dad113b1ceb11cb  k9s" && \
    mv -v k9s /usr/local/bin/k9s

WORKDIR /root

COPY . .
