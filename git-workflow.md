# Git Workflow

This document describes the workflow, conventions, and best practices we use with regard to Git. If you aren't already familiar with what Git does, how it works, and the basic commands (or you want a refresher), check out these links:

- [Atlassian git tutorial](https://www.atlassian.com/git/tutorial/git-basics) - Covers the basics of configuring git and creating/cloning repos
- [git - the simple quide](http://rogerdudler.github.io/git-guide/) - Introduces branches and pushing
- [gittutorial](http://git-scm.com/docs/gittutorial) - A little more detail on all this stuff
- [Interactive git](https://pcottle.github.io/learnGitBranching/) - With visualizations of branching, committing, etc
- [Meta link - links to 6 more tutorials](http://sixrevisions.com/resources/git-tutorials-beginners) - Git magic (5) covers a lot of details glossed over by the previous links

### Table of Contents

1. [Github as a Filesystem](#filesystem)
2. [Branching](#branching)
3. [Committing](#committing)
4. [Workflow](#workflow)

<a name="filesystem">
## Github as Filesystem

Since our work is highly collaborative, you should keep all of your progress it on Github so that your teammates can stay up to date on what you're working on. They may have ideas or suggestions, or they may just be curious. The goal is not to judge or criticize incomplete code, but to make sure we can all support and encourage each other as our code progresses.

There's also another reason to keep all of your work on Github: individual computers can get lost, stolen, or corrupted at any time. If your work is only saved locally, you run the risk of losing it if anything goes wrong on your computer (it could just be an accidental `rm -rf`...).

<a name="branching">
## Branching

`master` is the branch that gets deployed to production, so it should always be in a production-ready state (i.e. all tests should pass). Every change, whether it's a new feature, bug fix, or spelling correction, should be developed on a separate branch.

Branch names should be lower-case and use hyphens to separate words. Use descriptive branch names.

If your branch is the working branch for a project or issue (e.g. at Clever we use Jira), prepend your branch name by the issue tag, e.g. PROD-345-safe-sis-migration

    Good:

        bigger-api-keys
        sftp-row-validation-error
        clever-js-deps-update
        AGENTS-257-dockerize-worker

    Bad:

        no_sync_tag (uses underscores instead of hyphens)
        errors (not descriptive)
        rewrite-ongoing (not descriptive)

<a name="committing">
## Committing

A commit should contain one conceptual change to your code. This is crucial, so I will say it again. A commit should contain one self-contained, reversible, readable change to your code. This has numerous benefits:

- If you want to undo a change, you can revert a specific commit. If a commit contains multiple changes, you will have to manually undo individual changes.
- You can easily describe the changes in the commit message. This makes it easy to find the commit where a change was made.
- A reviewer (or anybody reading the code) can easily see which pieces of code are relevant to a change by looking at the commit for that change. If a commit contains multiple changes, it is often unclear which pieces of code are relevant to which change.

When committing, it's a good idea to review every line of code that you commit. Even if you have multiple conceptual changes implemented, craft your commits such that each commit only contains one change. A great way to do this is to use `git add -p`, which breaks your changes up into individual patches and allows you to interactively choose which ones to stage.

When writing commit messages, the first line should be a short description of the change. Since you only have one conceptual change in your commit, it should be easy to describe in one line, right? You may want to prefix this line with the name of the subcomponent/part of the system your changes affect followed by a colon (e.g. `student schema: added validation for email`). Use the rest of the commit message to expand on the context of the change so that it is easier to understand.

Good: TODO
Bad: TODO


#### Git Commit Style Guide

This is one git commit message format that you can follow.

Inspiration: [Deis Commit Style Guide](http://docs.deis.io/en/latest/contributing/standards/#commit-style-guide)

We often quote Deis in sections below.

##### Motivation

It makes going back and reading commits easier. It also allows you to spend less time thinking about what your commit message should be.

From the Deis Commit Style Guide:
> It allows us to recognize unimportant commits like formatting.
>
> It provides better information when browsing the git history.


##### Format of the Commit Message


```
{type}({scope}): {subject}
<BLANK LINE>
{body}
<BLANK LINE>
{footer}
```


##### Length

- Keep lines under 80 characters in width.
- Subject line must not be longer than 60 characters (one line in Github PR description).


##### Subject - {subject}

Summary of the changes made.

Deis:
> The subject line contains a succinct description of the change to the logic.

- Must be present tense
- Written in the imperative
- First letter is not capitalized
- Does not end with a '.'


##### Allowed Types - {types}

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


##### Scope - {scope}

Where the change was (i.e. the file, the component, the package).

Deis:
> It can be anything specifying place of the commit change e.g. the controller, the client, the logger, etc.


##### Message Body - {body}

This gives details about the commit, including:

- motivation for the change (broken code, new feature, etc)
- contrast with previous behavior

Some rules for the body:

- Must be in present tense.
- Should be imperative.
- Lines must be less than 80 characters long.


##### Message Footer - {footer}

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

##### Referencing Issues

Reference issues it fixes, project tags, etc.

- closes #14
- closes #14, #15
- addresses [comment](https://github.com/Clever/clever-js/pull/30#discussion_r16578611)

Here at Clever, we use Jira for project management. So best practice for us would be to add the jira issue key.

- Jira [PROD-190](https://clever.atlassian.net/browse/PROD-190)


##### Examples

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

<a name="workflow">
## Workflow

Here is the simplest development workflow you should use:

0. Get the latest version of `master`.

        cd some-repo
        git checkout master
        git pull

1.  Make a new branch off of `master`.

        git checkout -b my-great-feature

2. Implement your changes, pushing your commits along the way.

        git add -p
        git commit
        git push

    You should push early and often in order to ensure that the most up to date code is on Github - remember, use [github as a filesystem](#github-as-filesystem). That can mean pushing after every commit, or pushing every time you stop a work session. At the bare minimum, push before you stop for the day.

    If you are developing over a long period of time, and `master` is changing, you should merge `master` into your branch often to make sure it stays up to date. This will reduce merge conflicts when you finally merge your branch back into `master`.

        git checkout master
        git pull
        git checkout my-great-feature
        git merge master

4. When you are ready to start having your code reviewed, open a pull request (PR) and assign it to a reviewer.

     Make changes based on the reviewer's comments. Respond to comments with the SHA of the commit that address the comment so that both you and the reviewer can make sure every comment is addressed.

5. Once the reviewer signs off on the PR, rebase your branch to `master`. This will ensure that all of the commits from your branch will be next to each other once you merge into `master`, simplifying the history and making it easier to debug or rollback changes.

    This is also a good opportunity to clean up the commit history from your branch. Consider recombining commits into better logical chunks.

        git checkout master
        git pull
        git checkout my-great-feature
        git rebase -i master

6. Finally, merge your branch into `master`, delete your branch, and deploy. Since `master` should always be in a deployable state, you should deploy immediately after merging to ensure that your changes don't cause problems in production for the next person who wants to deploy.
