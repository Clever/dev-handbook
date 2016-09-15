# Glide

Glide is a tool for managing golang dependencies. You can use it to update, pin, and fetch dependencies. Some of the advantages of glide are:
  - Supports semantic versioning
  - No need to checkin the vendor directory
    - Allows per-package repository specification
    - Drone can use this to fetch private clever repositories!
  - Warns about dependency/version conflicts
    - i.e. two different versions of a pkg are being requested
  - Has fewer bugs than `godep` (or so it seems)


## Initializing a Glide Project

```bash
> export GO15VENDOREXPERIMENT=1
> glide init
> vim `glide.yaml` # set the package name (github.com/Clever/project)
```

You now have a `glide.yaml` with no dependencies specified. See the next sections on adding dependencies.

## Converting From Godeps

```bash
> glide import godep > tmp.yaml
> mv tmp.yaml glide.yaml
> rm -rf Godeps/ vendor/
```

At this point you now have a glide equivalent of your `Godeps/godeps.json` file. Dependencies should be listed and versions pinned where appropriate in the `glide.yaml`. You are now ready to install dependencies. See the next step.

## Using Glide With in Project

Add `Makefile` rules for downloading glide and installing the project's dependencies:
```make
export GO15VENDOREXPERIMENT=1

...

$(GOPATH)/bin/glide:
    @go get github.com/Masterminds/glide

install_deps: $(GOPATH)/bin/glide
    @$(GOPATH)/bin/glide install
```

### Download Project Dependencies
You can now run `make install_deps` to fetch the dependencies. They will be written into `vendor/`. **NOTE** You no longer need to checkin the `vendor` directory!

### Add Additional Dependencies

To add additional dependencies use `glide get <package>`

If the dependency is private, you will need to manually add it to `glide.yaml`, e.g.:

``` yaml
- package: github.com/Clever/private-repo
  version: <commit-ish>
  repo: git@github.com:Clever/private-repo.git
  vcs: git
  subpackages:
  - gen-go/client
  - gen-go/models
```

After editing `glide.yaml`, run `glide up` to update `glide.lock` and pull the new dependency into your vendor directory.
You might also want to run `make install_deps` again to remove any nested vendor directories.

### Pin Dependencies

Pin all your dependencies with `glide pin`. You can also edit the yaml file by hand and set specific versions using the `ref` attribute.

## Glide Examples

  - [Catapult](https://github.com/Clever/catapult)
  - [Ark](https://github.com/Clever/ark)

## Using private Clever repositories

With glide you don’t need to checkin the `vendor` directory, but in order to do this, you do need to add a little extra configuration when depending on private Clever repositories:

For each private `package` in your glide file, add a `vcs` and `repo`. Here is an example of depending on `catapult`

```yaml
- package: github.com/Clever/catapult
  version: 2913166e30d6e6cae7d2558b5a8edf64f2488b2d
  repo: git@github.com:Clever/catapult.git
  vcs: git
```

You will also need to edit the `.drone.yml` so that drone can access private Clever repos:
```yaml
script:
# setup ssh key
- echo ${drone_key} | sed 's|\\n|\n|g' > ~/.ssh/id_rsa
- chmod 600 ~/.ssh/id_rsa
# build and test rules
...
```

**Drone Setting (via web UI)**:
You will need to add drone's private ssh key for github.
  1. Edit the project settings and add `drone_key:`
  2. Copy the value from Clever/ark

The `clever-drone` user will need access to all of your private repo dependencies, so if you see an error in drone, ask a GitHub admin to grant the `clever-drone` user access to these repos.

**NOTE:** Infra may automate this step if glide becomes popular.
