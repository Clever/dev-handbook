Clever is committed to working with security experts around the world to stay up to date with the latest security techniques. If you have discovered a security issue that you believe we should know about, we'd love to hear from you. You can read about our security and privacy efforts on our [security page](https://clever.com/trust/security).

Coordinated disclosure rules
----------------------------
* Act in good faith. Do not leak, manipulate, download or destroy any user data, or affect the availability of the site. Test against accounts you yourself own, or with explicit permission of the account holder. Do not attempt to access data that does not belong to your test account(s).
* Alert us as soon as possible. Let us know upon discovery of a potential security issue, and we’ll make every effort to quickly correct the issue.
* Do not disclose to the public or anyone else the details of the vulnerability without discussing with us the vulnerability first. Provide us with a reasonable amount of time to fix the issue, any you may publish the vulnerability after we have confirmed we have remediated the issue. You can also publish if it has been nine (9) months since disclosure of the vulnerability to Clever's security team.
* Do not disclose to anyone any proprietary data revealed during your testing or the content of any data you accessed because of any vulnerabilities.
* Please use demo accounts. Not following the account creation steps below will render your report ineligible for a bounty. This includes automated/scripted account creation.
* Do not exploit any vulnerability beyond the minimal amount of testing required to prove that the vulnerability exists or to identify an indicator related to that vulnerability.
* Using automated scanners and testing tools to send a large number of requests (more than 1000 per day per endpoint) against the endpoints in the products, without prior notice or alerting to security@clever.com could render your report ineligible for bounty and could inevitably prompt us to disallow you from our program. If you are reporting a vulnerability regarding rate limiting or denial of service, you should let us know about the email address, account name, account ID, or other identifier associated with your testing setup, so that we can filter and attribute those large numbers of requests to you.
* You should include a custom HTTP header in all your traffic. For example:
  * A header that includes your username: X-Bug-Bounty: `HackerOne-Username`
  * A header that includes a unique or identifiable flag X-Bug-Bounty:`Unique-ID`

If you make a good faith effort to conduct research and disclose vulnerabilities in accordance with our disclosure rules above, Clever will not recommend or pursue law enforcement or civil lawsuits related to such activities.

Bounty eligibility
------------------
Vulnerabilities are eligible for the bug bounty program if they meet a minimum severity threshold. To qualify for a reward under this program, the vulnerability should:

* Represent an active threat to the confidentiality or integrity of Clever user data.
* Be possible to mitigate through standard defensive measures.
* Include a clear description along with steps to reproduce, including attachments such as screenshots or proof of concept code as necessary.

In general, the following would not meet the threshold for severity:

* Denial of service or general actions with the sole intent of causing annoyance.
* Issues surrounding emails:
  * infrastructure-wise: Clever's email server configuration (SPF, DKIM, and DMARC)
  * product-wise: content modification
* Name server configuration (DNSSEC, CAA, etc.).
* Issues that can't be obviously exploited, like self-XSS (an XSS that requires the user to enter a payload that is executed against themselves).
* Login/logout CSRF.
* Session management vulnerabilities related to sessions being invalidated after email/password change, inactivity, etc.
* Vulnerabilities affecting users of unsupported or unpatched browsers and platforms.
* Missing best practices in SSL/TLS configuration.
* Vulnerabilities on sites hosted by third-parties unless they lead to a vulnerability on the Clever services.
  * This includes denial of service or causing annoyance on third-parties used by Clever. Actions falling underneath these services will get you disqualified from the program.


Clever also reserves the right to deny eligibility for a vulnerability that was previously reported or discovered internally.

* Be the first to report a specific vulnerability.
* Disclose the vulnerability report directly and exclusively to us. Public disclosure or disclosure to other third parties, including vulnerability brokers, before we address your report will cause you to forfeit the reward.

Payout principles
-----------------
If a vulnerability doesn’t have an actively exploitable attack (e.g. you’d need access to third-party data, user would need to be on an outdated browser we don’t support, etc.), but we still fix it, researchers are offered a Clever T-Shirt.

The following guidelines suggest a base amount (impact x ease of exploitation) to pay out, but the actual payout will be determined with a broader context of the vulnerability.

| Impact | Amount | Scope |
|--------|--------|-------|
| Trivial | $50 | Some low-value user information is leaked or modifiable, or availability is minorly impacted. |
| Minor | $100 | More critical user information is leaked or modifiable, or availability is considerably impacted. |
| Major | $500 | Significant user information is leaked or modifiable, or availability is seriously compromised. |
| Critical | $1000 | Remote code execution, or takeover of arbitrary accounts. |

| Ease of exploitation | Multiplier | Reason |
|----------------------|------------|--------|
| Difficult | 0.5x | Requires complicated attack scenario with highly unusual access (e.g. Clever employee-level knowledge or similar). |
| Moderate | 1x | Somewhat difficult to exploit, or requires privileged access at some level (e.g. must have a trusted application account). |
| Easy | 2x | Requires only a moderate understanding of security vulnerability discovery and exploitation - no privileged access required. |
| Trivial | 3x | Can be found by simple vulnerability scanners. |

Setting up accounts
-------------------

Clever's bug bounty has four products in scope:
* Clever Portal (https://clever.com)
* Schools Dashboard (https://schools.clever.com)
* Application Dashboard (https://apps.clever.com)
* Clever API (https://api.clever.com)

These products all work together. To get access to accounts for testing, follow these instructions:

**Create an application developer account**
1. Go to the [application developer signup](https://apps.clever.com/signup) page.
2. Fill out the form, paying special attention to the following fields:
  * Use "HackerOne" as company name. *This is important, otherwise you won't be able to access the sandbox district account*.
  * Use an email address that you have access to. Do not use a "+" sign alias, as we will create a separate account using one.
  * Use an application name that starts with "#DEMO".
  * The other fields don't matter or can be changed later.

**Next, get access to the sandbox district account**
1. Go to the [schools password reset](https://clever.com/oauth/district_admin/recover-account) page.
2. Enter your email address with "+hackerone" appended to the name (e.g. if the email you used for the application developer signup was `name@example.com`, enter `name+hackerone@example.com`).
3. Wait for the password reset email to set up your password.
4. Go to your [portal settings](https://schools.clever.com/portal/settings) and copy your portal URL.

**Access the portal**
1. By default, the sandbox district portal is configured to use student and teacher numbers as the username and password.
2. Visit the [data browser](https://schools.clever.com/browser) and click on a teacher or student to get their student or teacher number.
3. Visit the portal URL and log in as a teacher or student.

 **Access the API**
For information about the API, see the [Clever Developer documentation](http://dev.clever.com/).

Please reach out with any questions to security@clever.com. Thank you for helping keep Clever safe!
