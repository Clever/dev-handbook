# Error Handling

## What is error handling?

Applications have a expected flow, and due to external circumstances sometimes will deviate from this flow. This deviation is considered an error and has to be handled accordingly. We dive into this handling later in this spec.

## What types of errors are there?

We can encounter errors for a variety of reasons, for example:

1. Unexpected input - From a user typing invalid information into an input to an unexpected file being uploaded there are countless ways a system can be utilized besides the intended use.
2. I/O or access failures - failure to send/receive data to/from network, device, etc. (Errors: out of disk space, memory, internet connection issues). Your system probably expects to access some sort of external system, and any unexpected responses should be handled.
3. Inconsitent state - You system may also make assumptions about the "state" of things. Maybe the internal machine state such as a directory structure has been changed. Maybe a user's session is missing some expected data.

These errors might be classifed under the following categories:

- Expected Errors - These are errors you explicity check for and throw. For example maybe you want to error and stop a flow if a user enters an invalid email. You'd explicitly validate the email, and if it was invalid you'd consider it an error.
- Unexpected Errors - These may come from anywhere, but won't happen if systems are working correctly. Examples of these could be the inconsitent state or I/O failures mentioned previously.

## How do you handle/respond to errors?
### 1. Before Errors Happen
Errors are inevitable. However, we strive to preempt errors with the following practices:

- [testing](https://github.com/Clever/dev-handbook/blob/testing/testing.md) - You should ideally test all parts of your system, so by definition you will test your error handling code. This includes writing tests for external I/O failures. This allows you to know how your system handles different error types.
- [code review](https://github.com/Clever/dev-handbook/blob/master/git-workflow.md) - During code review is another time to reflect on how an application will handle and react to different errors and conditions.

### 2. General Approaches to Error Handling
Error handling is different on an language by language and application by application basis. In general there are several things to keep in mind when designing error handling.

- Error Bubbling
    Often systems will depend on other services or modules, and in turn be depended on. Systems should expose a interface and make it clear when errors occur. This allows systems with enough context to handle the error to handle it correctly.
- DRY error handling
    On that note you should strive to error errors in as much of a central location as possible. This not only reduces code duplication, but it also makes it very clear in any context how to handle or throw errors, since they all bubble up to one place.
- When to fail hard vs soft
    Some errors can be swallowed and the execution of the program can continue. For example when loading data into a database the program can probably report invalid records and continue running.

    However some errors justify the halting of the program flow. For example if you loose a connection to the DB while loading data into it then that most likely justifies a hard failure.

### 3. Reporting Errors
Your program creates errors elegantly - so what? You'd better have a way to view those errors and respond to them. Outlets for reviewing errors include:

1. Logs - TBD
2. Notifications - Often you want to be notified when unpexted errors occur. We have email and Hipchat hooks that allow us to get notifications on system failures. Clever uses [Sentry](getsentry.com) to submit system error details. This allows you to keep a tab on which errors are occuring and which need to be responded to.
3. Rate monitoring - Some errors are permissible at certain rate. For example perhaps reading from external web services will sometimes be faulty. In other cases, an error may have been happening but not require repair (thus, the only signal is when a previously stable system transitions to a failing state, whereas constant old errors are noise). By monitoring the rate of occurences of these errors over time you can detect sudden changes which indicate a bigger problem.
4. Public Awareness - Sometimes, errors can immediate affect Clever's users, so we have a [Status Page](https://status.clever.com) to share downtime and stability stats that pulls from internal error metrics.

## Language Specifics

Below we've collected a few patterns for error handling Clever uses across our codebases.

Across different programming languages, there are a variety of approaches to handle errors. I focus on the paradigms we've adopted at Clever based on our infrastructure (AWS, Heroku) and coding languages (CoffeeScript, Python, Go).

1. CoffeeScript/Javascript
    - `Error` You can subclass the builtin Error class and throw different types of errors depending on the type of failure. You can then detect where a failure came from in a central error handler. Careful doing this though, there are [gotchas](https://github.com/Clever/clever-api/pull/155).
    - Async Methods
        We follow node callback style in most places, including the frontend or other places where this style has traditionally not been as prevalent.

        Async functions are called with arguemtns as normal, with the last argument being a callback.

        The callback has the signature `(err, data)` where data is equivlent to the return value of the function, and err is either an error or null.
    - Sync Methods
        Non async functions should throw errors that can be caught by the caller.
2. Python
    TBD
    - use `with` to explicitly declare resources being accessed (Redis Reservations. Selenium Driver instnaces)
    - `try/catch/finally`. use `finally` to cleanup on failed execution
3. Go
    TBD?
    - `panic` to output the stacktrace and stop
    - http://blog.golang.org/error-handling-and-go
    - Use error types
    - log.fatal to output the error and stop
