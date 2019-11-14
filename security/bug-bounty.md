Clever is committed to working with security experts around the world to stay up to date with the latest security techniques. If you have discovered a security issue that you believe we should know about, we'd love to hear from you. You can read about our security and privacy efforts on our [security page](https://clever.com/trust/security).

Coordinated disclosure rules
----------------------------
* Act in good faith. Do not leak, manipulate, or destroy any user data, or affect the availability of the site. Test against accounts you yourself own, or with explicit permission of the account holder. Do not attempt to access data that does not belong to your test account(s).
* Alert us as soon as possible. Let us know upon discovery of a potential security issue, and we’ll make every effort to quickly correct the issue.
* Let us triage, discuss, then publish. Provide us with a reasonable amount of time to fix the issue, and discuss with us before publishing it elsewhere.
* Please use demo accounts. Not following the account creation steps below will render your report ineligible for a bounty. This includes automated/scripted account creation.

Bounty eligibility
------------------
Vulnerabilities are eligible for the bug bounty program if they meet a minimum severity threshold. To qualify for a reward under this program, the vulnerability should:

* Represent an active threat to the confidentiality or integrity of Clever user data.
* Be possible to mitigate through standard defensive measures.
* Include a clear description along with steps to reproduce, including attachments such as screenshots or proof of concept code as necessary.

In general, the following would not meet the threshold for severity:

* Denial of service, spamming, or causing annoyance.
* Issues with Clever's email server configuration (SPF, DKIM, and DMARC) or name server configuration (DNSSEC).
* Issues that can't be obviously exploited, like self-XSS (an XSS that requires the user to enter a payload that is executed against themselves).
* Login/logout CSRF.
* Session management vulnerabilities related to sessions being invalidated after email/password change, inactivity, etc.
* Vulnerabilities affecting users of unsupported or unpatched browsers and platforms.
* Vulnerabilities on sites hosted by third-parties unless they lead to a vulnerability on the Clever services.

Clever also reserves the right to deny eligibility for a vulnerability that was previously reported or discovered internally.

* Be the first to report a specific vulnerability.
* Disclose the vulnerability report directly and exclusively to us. Public disclosure or disclosure to other third parties, including vulnerability brokers, before we address your report will cause you to forfeit the reward.

Payout principles
-----------------
If a vulnerability doesn’t have an actively exploitable attack (e.g. you’d need access to third-party data, user would need to be on outdated browser we don’t support, etc.), but we still fix it, researchers are offered a Clever T-Shirt.

The following guidelines suggest a base amount (impact x ease of exploitation) to pay out, but the actual payout will be determined with a broader context of the vulnerability.

| Impact | Amount | Scope |
|--------|--------|-------|
| Trivial | $50 | Some low-value user information is leaked or modifiable, or availability is minorly impacted. |
| Minor | $100 | More critical user information is leaked or modifiable, or available is considerably impacted. |
| Major | $500 | Significant user information is leaked or modifiable, availability is seriously compromised. |
| Critical | $1000 | Remote code execution, or takeover of arbitrary accounts. |

| Ease of exploitation | Multiplier | Reason |
|----------------------|------------|--------|
| Difficult | 0.5x | Requires complicated attack scenario with highly unusual access (e.g. Clever employee-level knowledge or similar). |
| Moderate | 1x | Somewhat difficult to exploit, requires privileged access at some level (e.g. must have a trusted application account). |
| Easy | 2x | Requires only a moderate understanding of security vulnerability discovery and exploitation - no privileged access required. |
| Trivial | 3x | Can be found by simple vulnerability scanners. |

Setting up accounts
-------------------
Many of our web services require authentication in order to access them. To assist in vulnerability finding, follow the appropriate instructions for the respective web service.

**Dashboard for school districts**
1. Go to the [schools demo signup](https://go.clever.com/districtsignup) page.
2. Fill out the form, paying special attention to the following fields:
  * Use a district name that starts with "#DEMO".
  * Select "Other" for role, and enter "Bug bounty security researcher" for title.
  * Select "Other" for Student Information System (SIS).
3. Wait for the onboarding email to setup your password on first login.
4. On login, you’ll need to setup rostering to create test teacher and student accounts.
  * Select “Sync” on the left-hand sidebar.
  * Select “Other” as the SIS type.
  * Upload some sample students through the [Web Upload](https://schools.clever.com/sync/upload) (accessible through Sync => Upload). Some example CSVs are provided on the page.
5. After some example data is synced with Clever, you can create the logins for those accounts.
  * Select “Portal” on the left-hand sidebar.
  * Select “[SSO Settings](https://schools.clever.com/instant-login/settings)” on the sub sidebar.
  * Click on the “Add Login Method” button.
  * Click on “Clever Passwords Authentication” to generate usernames and passwords.

**Dashboard for applications**
1. Go to the [application developer signup](https://apps.clever.com/signup) page.
2. Fill out the form, paying special attention to the following fields:
  * Use an application name that starts with "#DEMO".

Interacting between accounts
----------------------------
With a school district account and an application account, you can authorize using the application from the school district, to then test Instant Login.

**Testing Instant Login**
1. Sign in using your application account.
2. From the [Application](https://apps.clever.com/partner/applications) page, you can access the District Signup URL. This link allows your created school district to add and authorize the application to share data.
3. Once your district has approved the application, you can enable Instant Login to test it.

For more information, see the [Clever Developer documentation](http://dev.clever.com/).

Thank you for helping keep Clever safe!
