FROM alpine:3.5

RUN mkdir -p /var/cache/apk && ln -s /var/cache/apk /etc/apk/cache
RUN apk -U add \
  docker \
  bash \
  git \
  go \
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
  coreutils

ENV GOPATH $HOME/
ENV GOBIN /usr/local/bin
ENV BASH_ENV /root/.bashrc

RUN git config --global http.https://gopkg.in.followRedirects true
RUN pip install awscli
RUN go get github.com/jstemmer/go-junit-report

RUN curl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.5.3/bin/linux/amd64/kubectl \
    > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN curl -sSL https://github.com/gliderlabs/sigil/releases/download/v0.4.0/sigil_0.4.0_Linux_x86_64.tgz \
    | tar -zxC /usr/local/bin

RUN wget https://releases.hashicorp.com/terraform/0.8.7/terraform_0.8.7_linux_amd64.zip \
    && unzip terraform_0.8.7_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm terraform_0.8.7_linux_amd64.zip

COPY ./bashrc /root/.bashrc

CMD ["/bin/bash"]
