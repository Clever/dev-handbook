# Git Workflow

This document describes the workflow, conventions, and best practices we use with regard to Git. If you aren't already familiar with what Git does, how it works, and the basic commands (or you want a refresher), check out these links:

- [Atlassian git tutorial](https://www.atlassian.com/git/tutorial/git-basics) - Covers the basics of configuring git and creating/cloning repos
- [git - the simple quide](http://rogerdudler.github.io/git-guide/) - Introduces branches and pushing
- [gittutorial](http://git-scm.com/docs/gittutorial) - A little more detail on all this stuff
- [Interactive git](https://pcottle.github.io/learnGitBranching/) - With visualizations of branching, committing, etc
- [Meta link - links to 6 more tutorials](http://sixrevisions.com/resources/git-tutorials-beginners) - Git magic (5) covers a lot of details glossed over by the previous links

## Github as Filesystem

Since our work is highly collaborative, you should keep all of your progress on Github so that your teammates can stay up to date on what you're working on. They may have ideas or suggestions, or they may just be curious. The goal is not to judge or criticize incomplete code, but to make sure we can all support and encourage each other as our code progresses.

There's also another reason to keep all of your work on Github: individual computers can get lost, stolen, or corrupted at any time. If your work is only saved locally, you run the risk of losing it if anything goes wrong on your computer (it could just be an accidental `rm -rf`, which is how [Pixar accidentally deleted all of Toy Story 2](http://thenextweb.com/media/2012/05/21/how-pixars-toy-story-2-was-deleted-twice-once-by-technology-and-again-for-its-own-good/)).

## Branching

`master` is the branch that gets deployed to production, so it should always be in a production-ready state (i.e. all tests should pass). Every change, whether it's a new feature, bug fix, or spelling correction, should be developed on a separate branch.

Branch names should be lower-case and use hyphens to separate words. Use descriptive branch names. If there is a JIRA issue for the change, include the JIRA key (e.g. INFRA-101) in the branch name to link it to the JIRA ticket. This will automatically reference all commits in the JIRA ticket.

    Good:

        bigger-api-keys
        sftp-row-validation-error
        clever-js-deps-update
        INFRA-101-update-node-package

    Bad:

        no_sync_tag (uses underscores instead of hyphens)
        errors (not descriptive)
        rewrite-ongoing (not descriptive)

## Committing

A commit should contain one conceptual change to your code. This is crucial, so I will say it again. A commit should contain one self-contained, reversible, readable change to your code. This has numerous benefits:

- If you want to undo a change, you can revert a specific commit. If a commit contains multiple changes, you will have to manually undo individual changes.
- You can easily describe the changes in the commit message. This makes it easy to find the commit where a change was made.
- A reviewer (or anybody reading the code) can easily see which pieces of code are relevant to a change by looking at the commit for that change. If a commit contains multiple changes, it is often unclear which pieces of code are relevant to which change.

When committing, it's a good idea to review every line of code that you commit. Even if you have multiple conceptual changes implemented, craft your commits such that each commit only contains one change. A great way to do this is to use `git add -p`, which breaks your changes up into individual patches and allows you to interactively choose which ones to stage.

When writing commit messages, the first line should be a short description of the change. Since you only have one conceptual change in your commit, it should be easy to describe in one line, right? You may want to prefix this line with the name of the subcomponent/part of the system your changes affect followed by a colon (e.g. `student schema: added validation for email`). Use the rest of the commit message to expand on the context of the change so that it is easier to understand.

Commits to branches prefixed with the JIRA ticket id are automatically referenced in the JIRA ticket. For commits not associated with a branch, add the JIRA ticket id before the commit message:
```
SCHOOLS-631 - Removed authy config
```

### Whitespace changes
Whitespace changes and renaming/moving files are special cases and should be treated differently. In particlar, it can be diffiult to review code where there are large diffs that move chunks of code around.
 - git (and github) sometimes has trouble displaying changes when a file is both renamed and edited. Instead, make one commit for renaming/moving the files, and a second for the code changes.
 - When making signifiant whitespace changes/reflowing code, it's best to make one commit containing only whitespace changes (pro tip: pulls/<#>/files?w=1), and a second one containing the code changes.
By splitting the changes into commits that clearly change specific things (and making a note in the PR), it helps the reviewer go through the changes by commit, and make the mental switch to be looking for issue as appropriate, rather than having to confirm that everything is the same as before, except what was moved.

Good: TODO
Bad: TODO

## Pull Requests

We use the [shared repository model](https://help.github.com/articles/using-pull-requests/#shared-repository-model) of pull requests (PRs) for code reviews.

The description of a pull request must contain the following things:

- What does the change do? Typically this would be a one line description that goes in the "subject"
of the PR
- Why is this change needed? Provide a context around what motivates this change. This could be
an explanation inside the description or a reference to a discussion in some other place like
a mailing list, JIRA issue etc. Not only is it helpful for the reviewer, it can also be used to
figure out why a particular change was made when looking back.
- How is the change tested? Since you should be [testing all your changes](https://github.com/Clever/dev-handbook/blob/master/testing.md), provide that information in the PR description. This has two
benefits. It assures the reviewer that change indeed works correctly and he/she can prescribe
any additionals test if needed. It can also be used as a guideline for someone else making changes
to the same parts of the codebase.

[This](https://github.com/Clever/optimus/pull/12) is a good example of a PR description.

For more good advice on how to write and review a PR, see [Github's guidelines](https://github.com/blog/1943-how-to-write-the-perfect-pull-request).

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

    As a reviewer, use GitHub comments to communicate your feedback on the PR. Assign it to the
    requester after every batch of comments. Finally, assign it to the requester with an LGTM to
    sign off on the PR.

    As a requester, make changes based on the reviewer's comments. Respond to comments with the SHA
    of the commit that address the comment so that both you and the reviewer can make sure every
    comment is addressed. Once you have addressed the comments assign the PR back to the reviewer.
    Repeat this until the reviewer no longer has comments.

5. Once the reviewer signs off on the PR, rebase your branch to `master`. This will ensure that all of the commits from your branch will be next to each other once you merge into `master`, simplifying the history and making it easier to debug or rollback changes.

    This is also a good opportunity to clean up the commit history from your branch. Consider recombining commits into better logical chunks. Note that if you are working with someone on the same branch (uncommon here), make sure you are on the same page before rebasing and force pushing. If you don't force push then you will run into issues of being behind on your branch and merge conflicts ensues... You could read more about git rebase [here](https://help.github.com/articles/using-git-rebase/)

        git checkout master
        git pull
        git checkout my-great-feature
        git rebase -i master
        git push -f origin my-great-feature

6. Finally, merge your branch into `master`, delete your branch, and deploy. Since `master` should always be in a deployable state, you should deploy immediately after merging to ensure that your changes don't cause problems in production for the next person who wants to deploy.
