# Glide

## Glide Obsolete

Glide is obsolete.  It is replaced by Go Modules.

```bash
go mod help
```

## For older systems 

For repos not yet converted to go modules.

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

## Removing a Dependency

To remove a dependency, run `glide remove <package>`.

## Updating a single dependency

Manually edit your glide.yaml to point to the version of the dependency that you'd like to download.

If you're specifying a branch name, you might need to delete glide's cache of that repo if the branch has been force-pushed: `rm -r ~/.glide/cache/src/<folder for the repo>`.

Delete the folder in `vendor/` for the dependency.

Run `glide up` to pull down the dependency and then `make install_deps` to clear out nested vendor directories.

If your version is not updating, this may be due to multiple dependencies relying on different version. In this case, try to version lock the package in your glide.yaml and run `glide up` again. The output should log a `WARN` line describing which dependencies are conflicting.


## Glide Examples

  - [Catapult](https://github.com/Clever/catapult)
  - [Ark](https://github.com/Clever/ark)

## Using private Clever repositories in CI

With glide you don’t need to checkin the `vendor` directory, but in order to do this, you do need to add a little extra configuration when depending on private Clever repositories during CI.

See the CircleCI Ops guide for more info: https://clever.atlassian.net/wiki/display/ENG/Build+System
