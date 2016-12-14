# Godep

[TL;DR; how do I do X](#how-do-i)

Godep is a tool for vendoring dependencies.
Godep is a relatively explicit and blunt tool for copying dependencies into `/vendor`.
Due to the blunt nature, we have a small work around for nested `vendor` directories, but this should be automated by your Makefile.

Godep creates and saves a configuration file in `Godeps/Godeps.json`.
This shows which packages have their dependencies tracked as well as every dependency package and their versions.
View the [shorty godep config](https://github.com/Clever/shorty/blob/master/Godeps/Godeps.json) for an example.


## Makefile

Every Godep project should have the following variables and targets.
If they are not included, please add them for consistency.

```make
SHELL := /bin/bash
# use the Go toolchain to get a list of every Go package, we filter out packages in the vendor directory
PKGS := $(shell go list ./... | grep -v /vendor)
# thrift services should also filter out "gen-go"
# PKGS := $(shell go list ./... | grep -v /vendor | grep -v /gen-go)

# declaration of godep as well as ensuring that the most recent version is in use
GODEP := $(GOPATH)/bin/godep
$(GODEP):
    go get -u github.com/tools/godep

# a vendor target for pulling in new dependencies
vendor: $(GODEP)
    $(GODEP) save $(PKGS)  # pulls in any dependencies not already found in Godeps.json
    find vendor/ -path '*/vendor' -type d | xargs -IX rm -r X # remove any nested vendor directories
```


## Changing Dependencies

Given the following repo structure of a related API service and a worker:
```
github.com
├── Clever
│   ├── service (v1)
│       ├── models
│       ├── vendor (empty)
│   ├── worker (v1)
│       ├── db
|       ├── models
|       ├── collections
│       ├── vendor
│           ├── gopkg.in
│               ├── mgo (v2)
```

### New Packages

When adding a new package, you can simply use `make vendor` to update your imports.
This should bring in the new dependency that was previously undeclared.
The change should be reflected in `Godeps/Godeps.json` as well as `vendor/`.

So when `github.com/Clever/service/models` adds a dependency to `github.com/Clever/worker/models`, running `make vendor` should:
- add an entry to `github.com/Clever/service/Godeps/Godeps.json` for `github.com/Clever/worker/models`
  - NOTE: only the package, not the entire repo should have an entry
- copy all files from `github.com/Clever/worker/models` into `github.com/Clever/service/vendor/`

Let's say we then also start importing `worker/collections`, this should perform the same actions for that package.
The resulting repo structure should look like:

```
github.com
├── Clever
│   ├── service (v1)
│       ├── models
│       ├── vendor
│           ├── gopkg.in
│               ├── mgo (v2)
│           ├── github.com
│               ├── Clever
│                   ├── worker (v1)
│                       ├── models
│                       ├── collections
│   ├── worker (v1)
│       ├── db
|       ├── models
|       ├── collections
│       ├── vendor
│           ├── gopkg.in
│               ├── mgo (v2)
```

### Existing Packages

First ensure that you have your desired version of the package checked out in your `$GOPATH`.
In our structure, this means that we now have `v2` of `github.com/Clever/worker` checked out.

When changing the version of an existing package, you will need to use the godep tool manually without a Makefile target.
You must specify the package with the `update` command, if you use multiple subpackages of a repo you will need to specify all of them.
If you do not specify all packages, an error message of `godep: no packages can be updated` will be outputted.

So in order to upgrade `Clever/service` to use v2 packages from `Clever/worker`, we will need to specify both the packages.

```bash
$ pwd
~/go/github.com/Clever/service

# improper update without all subpackages of worker
$ godep update github.com/Clever/worker/models
godep: no packages can be updated

# proper upgrade of all subpackages
$ godep update github.com/Clever/worker/...
```

## How do I...?

### vendor my depedencies

1. Can you build your project yet?
  - If `go build` produces an executable, you're all set.
  - If it doesn't, you may need to pull in your requirements using `go get <dependency URL>`.
2. Do you have golang.mk hooked up to a `vendor` target in your Makefile?
  - Add [golang.mk](https://github.com/Clever/dev-handbook/blob/master/make/golang.mk) to your repo
  - Copy the [`vendor` target](https://github.com/Clever/shorty/blob/master/Makefile) into your Makefile
3. Are all of your dependencies up to date locally?
  - If you rely on any client libraries, you should update your local copy of those clients (`git checkout master && git pull`)
4. run `make vendor`
  - If it fails, first try updating `godep` with `go get -u github.com/tools/godep`
  - Then you can move to #golang for debugging help

### remove a dependency

1. Can you build your project with this dependency?
  - If `go build` produces an executable, you're all set.
  - If it doesn't, you may need to pull in your requirements using `go get <dependency URL>`.
2. run `make vendor`

### add a new dependency

1. Can you build your project with this dependency?
  - If `go build` produces an executable, you're all set.
  - `godep: Package (X) not found` -- godep requires that *all* packages are in your `GOPATH`.
    - `godep restore` will copy all dependecies in your `vendor/` directory into your `GOPATH`.
    - Warning: this will checkout different versions of your `GOPATH` libraries if they do not match
  - If it doesn't, you may need to pull in your requirements using `go get <dependency URL>`.
2. run `make vendor`
  - This pulls the new dep into your vendor/ directory
  - If it fails, first try updating `godep` with `go get -u github.com/tools/godep`
  - Then you can move to #golang for debugging help

### update a new dependency

1. Can you build your project with this dependency?
  - If `go build` produces an executable, you're all set.
  - `godep: Package (X) not found` -- godep requires that *all* packages are in your `GOPATH`.
    - `godep restore` will copy all dependecies in your `vendor/` directory into your `GOPATH`.
    - Warning: this will checkout different versions of your `GOPATH` libraries if they do not match
  - If it doesn't, you may need to pull in your requirements using `go get <dependency URL>`.
2. Make sure you have the new version you want checked out in your `GOPATH`
  - cd `$GOPATH/src/githbu.com/my/dependency && git checkout master && git pull`
3. Upgrade via godep
  - `godep update github.com/my/dependency/...`
  - The `/...` will pull in all subpackages, otherwise they must be specified individually

## Committing Vendored Files

We choose to commit our vendored files for explicitness and faster CI builds.
