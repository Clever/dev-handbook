Logging
=======

A log is a sequential file that stores information about transactions and the state of the system at certain instances. Logging is the process of adding lines to this file.

The purpose of logging is to allow transparency into computer programs. It is used to keep tabs on processes running and to allow investigative analysis. Some examples of when logs are investigated include: audits, crash reports, partner dialogs, certain aggregation metrics, and diagnosing problems.

Logging can focus on a particular part of code (unit) or on a whole process (integration).

Logs are broken into severity levels. Each level has a set of standards. These levels are grouped into four larger categories that we are more concerned with:

  1. Process Layer
  2. Application Errors
  3. Application Audit Information
  4. Application Statuses

Process Layer (ops)
----------------------

*e.g. containers, process control systems, buildpacks, etc*

These logs are usually dealt with in dev-ops environments.

| Level | Name           | Description                                                                        | About |
|------:|:---------------|:-----------------------------------------------------------------------------------|:------|
| 0     | **Emergency**  | *Emergency: system is unusable*                                                    | The highest priority, usually reserved for catastrophic failures and reboot notices. |
| 1     | **Alert**      | *Alert: action must be taken immediately* | A serious failure in a key system </br> - These are the Pagerduty alarms. They often bubbles up from error, warning, or critical logs. | 



Application Errors
---------------------

#### Levels

| Level | Name           | Description                                                                        | About |
|------:|:---------------|:-----------------------------------------------------------------------------------|:------|
| 2     | **Critical**   | *A failure in a key system.*                                                    | This is when an error occurred and the process cannot recover and continue. </br> - It is often logged right before exiting with code 1. </br> (See error handling documentation for best error handling practices) </br> e.g. "could not connect to database" | 
| 3     | **Error**      | *Something has failed* | This is when an error occurred but we recovered and the application can continue running. </br> (See error handling documentation for best error handling practices) </br> e.g. "requested page does not exists" | 


#### Logging practices
1. Log error:

    **Node**: use 'console.error' or use a logging library

    **Python**: use 'logging.error'

    **Go**: 'log.Errorf' or use a logging library

2. Send to Sentry or appropriate error alert system.


#### Logging Format

1. error context (which function etc)
2. message/reason
3. type user/external/internal
4. stack trace
5. (error code? used to find exact line where error was thrown, see error documentation)


Application Audit Information
--------------------------------

#### Levels

| Level | Name           | Description                                                                        | About |
|------:|:---------------|:-----------------------------------------------------------------------------------|:------|
| 4     | **Warning**   | *Something is amiss and might fail if not corrected.*                                                    | These are warning messages (not an error) but an indication that an error will occur if action is not taken. </br> e.g. "file system 85% full" |
| 5     | **Notice**   | *Things of moderate interest to the user or administrator.*                                                    | This is information such as progress information, significant events, auditing information. </br> e.g. "worker Y started with payload X" |



#### Logging Practices

1. Log starting and ending of major components or anything needed to show the major work flow of our system.

    **Node**: use 'console.log' *todo - use a logging library*

    **Python**: use 'logging.info'

    **Go**: 'log.Print(f|ln)' *todo - use a logging library*


#### Logging Format

1. component name (e.g. which process/worker)
2. input or output
3. actor (user, process name, system id)

    e.g. "system\_id=123456789012: csv-processor started with payload '123456789012'"
  "system\_id=123456789012: csv-processor successfully reserved 'reservation-123456789012'"


Application Status
---------------------

#### Levels

| Level | Name           | Description                                                                        | About |
|------:|:---------------|:-----------------------------------------------------------------------------------|:------|
| 6     | **Info**   | *The lowest priority that you would normally log, and purely informational in nature.*                                                    | This is the most common type of logging. It explains how the application is running, what component is running at what point, etc. It is mostly for investigative purposes after the fact. </br> e.g. "validating url" |
| 7     | **Debug**   | *This is the lowest priority, and normally not logged except for messages from the kernel.*                                                    | This is the lowest priority, and normally not logged except for messages from the kernel.|

### Info (level 6)

#### Logging Practices

- Log starting and ending of major components or anything needed to show the major work flow of our system.

    **Node**: use 'console.log' *todo - use a logging library*

    **Python**: use 'logging.info'

    **Go**: 'log.Print(f|ln)' *todo - use a logging library*


#### Logging Format

1. Component name
2. Message/reason
3. Context (often input or env info)

    *name any object you dump (like payload, uri, csv headers, DOM object)*

    e.g. "csv-processor:info validating input payload '{"archive": ObjectId("123456789012")}'"
        

**NOTE** Individual lines should be readable and provide any necessary context to understand what is going on at that point.

**NOTE** Avoid info logs within loops


### Debug (level 7)

#### Debugging Practices
- Add debug lines as you see fit.

    **Node**: use 'debug'

    **Python**: use 'logging.debug'

    **Go**: no standard at the moment


##### Debugging Format
There is no standard format. Debugging is for whatever you need as it is only for the development environment.

**NOTE** Your code is for developers too, so make it clear why you are logging something or needed to log something.


Security
--------

**Don't log credentials!**

- log usernames not username/password pairs
- don't log sensitive information (e.g. student data)

**NOTE** Ask yourself: would it be ok to send these logs on Hipchat or to a auditor? If not, don't log it. This is a must for notice level and above.


Best Practices
--------------

**Individual lines should be *readable* and provide any necessary *context* to understand what is going on at that point.**

- Remember: consecutive lines for one process are not necessarily consecutive in the logs once aggregated.

- Be concise.

- Log lines should be filterable - if components go together, you should be able to filter for those components.

- Log messages should link related processes (e.g. using a prefix, using a common id across a system).

- Follow logging format to be set out below.



TODO: logging format, machine parsable but still human readable
