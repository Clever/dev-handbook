# Glide

Glide is a tool for managing golang dependencies. You can use it to update, pin, and fetch dependencies. Some of the advantages of glide are:
  - Supports semantic versioning
  - No need to checkin the vendor directory
    - Allows per-package repository specification
    - Drone can use this to fetch private clever repositories!
  - Warns about dependency/version conflicts
    - i.e. two different versions of a pkg are being requested
  - Has fewer bugs than `godep` (or so it seems)


## Initializing a Glide project

```bash
> glide init
> emacs glide.yaml # set the package name (github.com/Clever/project)
```

You now have a `glide.yaml` with no dependencies specified. See the next sections on adding dependencies.

## Converting from Godeps

```bash
> glide create && glide update
> rm -rf Godeps
```

At this point you now have a glide equivalent of your `Godeps/Godeps.json` file.
Dependencies and their versions should be listed in the `glide.yaml`.
This also creates a `glide.lock` file which lists the exact refs of the dependencies.
In most cases these versions are the same as the `glide.yaml`, but wouldn't be if your `glide.yaml` file uses semantic versioning.
You should never edit the `glide.lock` file, only the `glide.yaml` file.

You are now ready to install dependencies. See the next step.

## Using Glide within a project

Add `Makefile` rules for downloading glide and installing the project's dependencies:
```make
...

$(GOPATH)/bin/glide:
    @go get github.com/Masterminds/glide
```

### Add additional dependencies

Add additional dependencies use `glide get <package>`

### Update dependencies

The `glide update <package>` command updates a dependency to the latest version that matches its version specification in the yaml file.
What this means:
  - if the version is specified as a git hash, it does nothing. You'll need to modify the glide.yaml file and run `glide update` (similar to the process for updating npm dependencies)
  - if the version specified is a semantic version, it downloads the latest version matching that semver string.

## Glide Examples

  - [Catapult](https://github.com/Clever/catapult) (w/o dependencies checked in)
  - [Ark](https://github.com/Clever/ark) (w/o dependencies checked in)
  - [District Authorizations](https://github.com/Clever/district-authorizations) (w/ dependencies checked in)

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

**NOTE:** Infra may automate this step if glide becomes popular.
