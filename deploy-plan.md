## Purpose
Releasing often causes headaches (including downtime) at Clever, and increases the amount of time between specs and release. It also causes us to waste energy redoing and re-coordinating.
With proper release plans, these issues will be avoided and more time can be spent doing 1337 hacking.

## Things to think about
- Both upstream and downstream systems might be affected by your change.
- Have a sense of what needs to be done to get it deployed

## Post Deploy

After the deployment has gone through, remember to:
- validate downstream projects are still fine, in some cases
  - For instance, if you are releasing `clever-db`, there are a ton of projects which rely on its behavior. Until we use semver correctly, these projects may fail to build the next time. At least make sure that `clever-api` (or other important downstream project) has built and passed tests against your new deployment before you get on a plane.
  - TODO: bake functionality into Drone that does this for us- see [Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Terminology) for an example

## Example scenarios

### JSON-Schema Validation in the API
With the [JSON-Schema changes to the API](https://github.com/Clever/specs/blob/master/json-schema-validation.md), there were changes in three repos:
- `json-schema-converter`
- `clever-db`
- `clever-api`
We were essentially tightening up the validation of what queries coming in were valid - before this invalid parts of where queries were silently ignored.

#### What we did right:
- To make sure that we weren't removing functionality people depended on, we analyzed the API logs and saw that the problematic queries we were disallowing would not start sending partners 400 errors that they were not expecting.
- We left the repos with more tests than we found them
- One person managing releases
- Releases not on Fridays, quick responses to issues that came up
- Extensive review of other systems to make sure nothing else relied on the code we were changing
- Followed `semver` conventions for `json-schema-converter`

#### What we did wrong:
- We released a `clever-db` PR (in preparation for releasing `clever-api`) that broke `clever-api` in some places. While we had fixed `clever-api` to use the new format, that commit was still in a being-reviewed branch and `master` on `clever-api` started failing.
- Right before releasing the API, we fixed some issues which were slightly out of scope. These changes caused the API to be very, very slow when released.
- During deployment, a not-very-experienced member of the team deployed the API, and missed a step, causing API downtime.
- Did not follow `semver` conventions for `clever-api`, `clever-db`
- Did not make sure that downstream `clever-api` master still built after merging `clever-db` changes, even if at the time we thought there were no API/dep changes

### Sphinx?
