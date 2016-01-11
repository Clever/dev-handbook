# Make

This is intended to host our Makefile "libraries."
The intention is to allow mass updating of all golang/thrift/etc specific rules without manually editing each Makefile.

All rules and definitions are namespaced with their filename.
I.e. all names in golang.mk start with `golang-`.

All definitions should have a `-deps` target to ensure that the dependencies are ready.
I.e. `foo-bar` in foo.mk should have a `foo-bar-deps` target.


## make meta-programming

This takes advantage of several less commonly used make features

- [the `include` directive](http://www.gnu.org/software/make/manual/make.html#Include)
- [the `define` directive](http://www.gnu.org/software/make/manual/make.html#Multi_002dLine)
- [the `eval` function](http://www.gnu.org/software/make/manual/make.html#Eval-Function)

[This blog post](http://make.mad-scientist.net/the-eval-function/) provides a nice overview of how these can all be leveraged together.


## Golang

- version check
- godep
- testing
  - gofmt
  - golint
  - go vet
  - go test


## Thrift

- thrift generate
  - golang
  - node
  - python
- verification of up-to-date client code


