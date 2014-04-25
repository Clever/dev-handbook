## Purpose
when you write stuff, you have no concern about when and how it's going to be deployed

## Things to think about
- Both upstream and downstream systems might be affected by your change.
- have a sense of what needs to be done to get it deployed
- spec should have info on it -> unless it's just agent changes, etc that already have processes around them AND no deps

## Example scenarios

## Link to deploy tools
- jira subtask!!!
  - checklist of items
     - config changes
     - actual line by line items you need to deploy
     - upstream and downstream affected projects / systems
- link to pr-notifier-like tool that reminds people to tag releases

## Deployment
Common sense rules the day here - WWM(ohit)D
This means- don't try to release the API on a Friday afternoon, etc.

The checklist (to go into JIRA?)
- have deploy plan if impactful-enough project
- notify on `clever-dev` hipchat and to whomever is affected by the *process* of the release
- release

## Post Deploy

After the deployment has gone through, remember to:
- verify deployment
- tag releases
- validate downstream projects are still fine, in some cases
  - For instance, if you are releasing `clever-db`, there are a ton of projects which rely on its behavior. Until we use semver correctly, these projects may fail to build the next time. At least make sure that `clever-api` (or other important downstream project) has built and passed tests against your new deployment before you get on a plane.
  - TODO: bake functionality into Drone that does this for us- see [Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Terminology) for an example
