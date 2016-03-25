Clever is committed to working with security experts around the world to stay up to date with the latest security techniques. If you have discovered a security issue that you believe we should know about, we'd love to hear from you. You can read about our security and privacy efforts on our [security page](https://clever.com/security).

Coordinated disclosure rules
----------------------------
* Please let us know as soon as possible upon discovery of a potential security issue, and we’ll make every effort to quickly correct the issue.
* Provide us with a reasonable amount of time to fix the issue before publishing it elsewhere.
* Make a good faith effort to not leak, manipulate, or destroy any user data, or affect the availability of the site. Please only test against accounts you own yourself or with explicit permission of the account holder.
* Please refrain from automated/scripted account creation.

Bounty eligibility
------------------
Vulnerabilities are eligible for the bug bounty program if they meet a minimum severity threshold. To qualify for a reward under this program, the vulnerability should:

* Represent an active threat to the confidentiality or integrity of Clever user data.
* Be possible to mitigate through standard defensive measures.
* Include a clear description along with steps to reproduce, including attachments such as screenshots or proof of concept code as necessary.

In general, the following would not meet the threshold for severity:
* Vulnerabilities on sites hosted by third-parties unless they lead to a vulnerability on the Clever services.
* Denial of service, spamming, or causing annoyance.
* Issues with Clever's email server configuration (SPF, DKIM, and DMARC) or name server configuration (DNSSec).
* Issues that can't be obviously exploited, like self-XSS (an XSS that requires the user to enter a payload that is executed against themselves).
* Login/logout CSRF.
* Vulnerabilities affecting users of unsupported or unpatched browsers and platforms.

Clever also reserves the right to deny eligibility for a vulnerability that was previously reported or discovered internally.
* Be the first to report a specific vulnerability.
* Disclose the vulnerability report directly and exclusively to us. Public disclosure or disclosure to other third parties, including vulnerability brokers, before we address your report will cause you to forfeit the reward.

Scope
-----
The following web services are in scope for this program:
* https://clever.com (main website)
* https://schools.clever.com (dashbaord for school districts)
* https://apps.clever.com (dashboard for applications)
* https://clever.com/oauth (instant login)
* https://clever.com/in/ (portal)
* https://requests.clever.com (districts request access to an app)

**Signing up for a school district account**

1. Go to the [schools signup](https://schools.clever.com/signup) page.
2. Complete signup, and use a new district name that starts with "#DEMO". Click "Add".
3. Click "Step 1: Set up accounts"
4. Select "Custom username and password" for the accounts
5. For usernames and password, select "Clever Passwords based on SIS Data (Recommended)"
6. For student information system, select "Other" and use any name.
7. Upload sample data through the [Web Upload](https://schools.clever.com/settings/system/upload) interface, which you can find under Settings => Sync. You can find a set of sample .csv files there.

**Signing up for an application account**

1. Go to the [application developer signup](https://apps.clever.com/signup) page.
2. Complete signup, and use an application name that starts with "#DEMO".
3. From the [Application](https://apps.clever.com/partner/applications) page, you can access the District Signup URL. You can visit that link while signed in as a school district user to add the application and share data.
4. Once the district has approved the application, you can enable Instant Login for them to test it.

For more more information, see the [Clever Developer documentation](http://dev.clever.com/).

You can also see a demo of Instant Login [here](https://www.youtube.com/watch?v=tblg884yjQU).

Thank you for helping keep Clever safe!
