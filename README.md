# Woven

An Application Developers Dream Deployment UI Request

Please leave thoughts, critiques, etc in [Issues](https://github.com/jskulski/woven/issues). 

## Usage

### Deploying

```
$ git status branch
feature-branch

$ woven status
Healthy:
    Strand 1 - master (25%)
    Strand 2 - master (25%)
    Strand 3 - master (25%)
    Strand 4 - master (25%)

$ woven deploy
Woven is deploying `feature-branch` to `production` to `Strand 4`
```

### Status

```
$ woven status
Healthy:
    Strand 1 - master (33%)
    Strand 2 - master (33%)
    Strand 3 - master (33.9%)
    Strand 4 - feature-branch (0.1%)
```

If there are:
- CPU/Memory in X% of avg
- No exceptions
- No warnings/error in the logs

The traffic percentage increases until every thing is balanced out over a period of 5 minutes later

```
$ woven status
Healthy:
    Strand 1 - master (25%)
    Strand 2 - master (25%)
    Strand 3 - master (25%)
    Strand 4 - feature-branch (25%)
```

If there are no errors over Y time period, feature-branch is
merged into master (if there are conflicts someone is alerted).

```
$ woven status
Healthy:
    Strand 1 - master (25%)
    Strand 2 - master (25%)
    Strand 3 - master (25%)
    Strand 4 - master (25%)
```

If there were errors

```
$ woven status
Healthy:
    Strand 1 - master (25%)
    Strand 2 - master (25%)
    Strand 3 - master (25%)
    Strand 4 - master (25%)

Unhealthy:
    Strand aef173 - feature-branch (0%)
        Added on 4/09/2016 at 12:28pm
        Removed on 4/10/2016 at 05:28pm
        - 10% increase in CPU
        - 5 Exceptions, 127 Warnings in 48 hours
        More info: http://woven.io/report/123838219
```

## Process

You have some code to deploy. `woven deploy`:

- pushes your feature branch to a git server we host
- pick up that change
- tell traffic shaper to remove one app instance from the public traffic
- split traffice between remaining instances
- deploy feature branch to that instance
- tell traffic shaper to start pushing traffic to feature-branch deploy
- over a configurable period, start monitoring logs, events etc.
- remove from traffic and report if errors, cpu problems, etc
- shift traffic till it is balanced
- merge to master if stable and OK after configurable length: time or # of requests?)

## Alerts

Integrate with pingdom/pagerduty/etc
Send SMS, email?

### Initialization

```
$ woven init project-name
Creating woven.yml for you. Push your code to

    git@woven.io/project-name

and we'll take care of the rest.
```

```
$ cat woven.yml
host:
    provider: heroku
    api_key: HEROKU_API_KEY
    # aptible, heroku, ec2, etc

ci:
    provider: travis-ci
    api_key: TRAVIS_API_KEY

repo:
    url: git@github.com/jskulski/my-project.git
    api_key: GITHUB_API_KEY # Environment variables do we need to configure?

strands:
    number_of_healthy_strands: 4
    time_to_balance: 5 minutes
    time_to_merge: 7 days
```

