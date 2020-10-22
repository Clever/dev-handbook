FROM golang:1.13-stretch

COPY ark/ /go/src/github.com/Clever/ark/
COPY golang-v1.mk /go/src/github.com/Clever/ark/golang.mk
COPY Makefile /go/src/github.com/Clever/ark/Makefile


WORKDIR /go/src/github.com/Clever/ark

ENTRYPOINT ["/bin/bash"]

# docker run -v ~/.gitconfig:/root/.gitconfig -v ~/.ssh/:/root/.ssh/ -it make
