#FROM alpine:3.5
FROM golang:1.8-alpine

RUN mkdir -p /var/cache/apk && ln -s /var/cache/apk /etc/apk/cache
RUN apk -U add \
  docker \
  bash \
  git \
  build-base \
  glide \
  openssh \
  curl \
  groff \
  less \
  python \
  py-pip \
  wget \
  unzip \
  ca-certificates \
  jq \
  coreutils

ENV GOPATH /go
ENV GOBIN /usr/local/bin
ENV BASH_ENV /root/.bashrc

RUN git config --global http.https://gopkg.in.followRedirects true
RUN pip install awscli
RUN go get github.com/jstemmer/go-junit-report

ENV KUBECTL_VERSION 1.5.3
RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

ENV KOPS_VERSION 1.5.3
RUN curl -sSL https://github.com/kubernetes/kops/releases/download/${KOPS_VERSION}/kops-linux-amd64 \
    > /usr/local/bin/kops \
    && chmod +x /usr/local/bin/kops

ENV SIGIL_VERSION 0.4.0
RUN curl -sSL https://github.com/gliderlabs/sigil/releases/download/v${SIGIL_VERSION}/sigil_${SIGIL_VERSION}_Linux_x86_64.tgz \
    | tar -zxC /usr/local/bin

ENV TERRAFORM_VERSION 0.8.8
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

COPY ./bashrc /root/.bashrc

CMD ["/bin/bash"]
