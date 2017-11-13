#!/usr/bin/env bash
set -e

# script to determine jsx files that have been modified recently on a branch
# a couple of mutative things that this script does to be aware of
# - it will run `git remote prune origin` to prune nonexistent remote branches from your local git repo
# - it will create some files in /tmp

git fetch origin
for branch in `git branch -r | grep -v HEAD | grep -v codemod`; do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r > /tmp/remote_branches
grep -E "(2 weeks|days|hours|minutes|seconds)" /tmp/remote_branches | tee /tmp/recent_remote_branches
cut -d'	' -f2 /tmp/recent_remote_branches > /tmp/branch_names

rm -rf /tmp/branchinfo
mkdir /tmp/branchinfo
for branch in `cat /tmp/branch_names`; do
    git diff --name-only origin/master...$branch > /tmp/branchinfo/`echo $branch | sed 's/origin\///'`
done

echo "jsx files being worked on:"
cat /tmp/branchinfo/* | sort | uniq | grep jsx > /tmp/jsx-files-worked-on
cat /tmp/jsx-files-worked-on

echo "jsx files available to lint:"
git ls-files | grep jsx | sort > /tmp/jsx-files-all
comm -23 /tmp/jsx-files-all /tmp/jsx-files-worked-on | tee /tmp/jsx-files-to-lint
