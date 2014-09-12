Git Commit Style Guide
=====================

Inspiration: [Deis Commit Style Guide](http://docs.deis.io/en/latest/contributing/standards/#commit-style-guide)

I often quote Deis in sections below.

## Motivation

It makes going back and reading commits easier. It also allows you to spend less time thinking about what your commit message should be.

From the Deis Commit Style Guide:
> It allows us to recognize unimportant commits like formatting.
>
> It provides better information when browsing the git history.


Format of the Commit Message
----------------------------

```
{type}({scope}): {subject}
<BLANK LINE>
{body}
<BLANK LINE>
{footer}
```

Rules for Commit Message
-----------------------


#### Length

- Keep lines under 80 characters in width.
- Subject line must not be longer than 60 characters (one line in Github PR description).


#### Subject - {subject}

Summary of the changes made.

Deis:
> The subject line contains a succinct description of the change to the logic.

- Must be present tense
- Written in the imperative
- First letter is not capitalized
- Does not end with a '.'


#### Allowed Types - {types}

- feat -> feature
- fix -> bug fix
- docs -> documentation
- style -> formatting, lint stuff
- refactor -> code restructure without changing exterrnal behavior
- test -> adding missing tests
- chore -> maintenance
- init -> initial commit
- rearrange -> files moved, added, deleted etc
- update -> update code (versions, library compatibility)


#### Scope - {scope}

Where the change was (i.e. the file, the component, the package).

Deis:
> It can be anything specifying place of the commit change e.g. the controller, the client, the logger, etc.


#### Message Body - {body}

This gives details about the commit, including:

- motivation for the change (broken code, new feature, etc)
- contrast with previous behavior

Some rules for the body:

- Must be in present tense.
- Should be imperative.
- Lines must be less than 80 characters long.


#### Message Footer - {footer}

These are notes that someone should be aware of. Format footer in category blocks.

- TESTING -> how to test the change
- BREAKING CHANGE -> what is different now, additional things now needed, etc


For example:

```
TESTING: to test this change, bring up a new cluster and run the following
when the controller comes online:

    $ vagrant ssh -c "curl localhost:8000"

you should see an HTTP response from the controller.

BREAKING CHANGE: the controller no longer listens on port 80. It now listens on
port 8000, with the router redirecting requests on port 80 to the controller. To
migrate to this change, SSH into your controller and run:

    $ docker kill deis-controller
        $ docker rm deis-controller

and then restart the controller on port 8000:

    $ docker run -d -p 8000:8000 -e ETCD=<etcd_endpoint> -e HOST=<host_ip> \
            -e PORT=8000 -name deis-controller deis/controller

now you can start the proxy component by running:

    $ docker run -d -p 80:80 -e ETCD=<etcd_endpoint> -e HOST=<host_ip> -e PORT=80 \
            -name deis-router deis/router

the router should then start proxying requests from port 80 to the controller.
```

#### Referencing Issues

Reference issues it fixes, Jira tasks, etc.

- Jira [PROD-190](https://clever.atlassian.net/browse/PROD-190)
- closes #14
- closes #14, #15
- addresses [comment](https://github.com/Clever/salt/pull/215#commitcomment-7704308)


## Examples

From Deis:

```
feat(controller): add router component

This introduces a new router component to Deis, which proxies requests to Deis
components.

closes #123

BREAKING CHANGE: the controller no longer listens on port 80. It now listens on
    port 8000, with the router redirecting requests on port 80 to the controller.
        To migrate to this change, SSH into your controller and run:

        $ docker kill deis-controller
                $ docker rm deis-controller

    and then restart the controller on port 8000:

        $ docker run -d -p 8000:8000 -e ETCD=<etcd_endpoint> -e HOST=<host_ip> \
                -e PORT=8000 -name deis-controller deis/controller

    now you can start the proxy component by running:

        $ docker run -d -p 80:80 -e ETCD=<etcd_endpoint> -e HOST=<host_ip> -e PORT=80 \
                -name deis-router deis/router

    The router should then start proxying requests from port 80 to the controller.
    ```

```
test(client): add unit tests for app domains

Nginx does not allow domain names larger than 128 characters, so we need to make
sure that we do not allow the client to add domains larger than 128 characters.
A DomainException is raised when the domain name is larger than the maximum
character size.

closes #392
```
