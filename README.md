# Appian Git Hooks Framework

This repo contains hook scripts and files for use with the Appian Git hooks framework. This framework is a customization layered on top of the open-source [Pre-Commit Git hook framework](https://github.com/pre-commit/pre-commit). See the [Pre-Commit documentation](https://pre-commit.com/) for more details.

The hooks in this repo are only implementations.  The decision to turn these hooks on or off, and when to invoke them, is indicated in the `.pre-commit-config.yaml` file contained in each repository in which the framework is installed.

## Setting Up Git Hooks Framework in a Repository

In order to install the Git hooks framework and activate it for a particular repository, perform the following actions:

1. Ensure that you have the Appian [tech-tools repo](https://github.com/appian/tech-tools) cloned on your local machine.
1. Execute the following command:

```ShellSession
~/repo/tech-tools/git/hooks/install-git-hooks.sh
```

This will invoke a script to install all the necessary hook support packages, and will also initialize the hook framework.  Some of the steps may take some time, so please be patient and allow the script to run to completion.

## List of Hooks

Listed below are the Git hooks contained in this repository.  In many cases, they are wrappers that invoke other linting or formatting tools.  In those cases, the links in the list below will take you to the pages for the main tools.

### General Hooks

* [commit-message-line-length](https://github.com/rob-orr/git-hooks/blob/master/pre_commit_hooks/commit-message-line-length.sh) - checks that commit message lines do not exceed 72 characters
* [fetch-notes](https://home.appian.com/suite/tempo/news/entry/b-304103) - retrieves Git notes for repo
* [num-files-in-commit](https://github.com/rob-orr/git-hooks/blob/master/pre_commit_hooks/num-files-in-commit.sh) - checks that the number of files in a commit does not exceed Appian guidelines
* [send-telemetry](https://github.com/rob-orr/git-hooks/blob/master/pre_commit_hooks/send-telemetry.sh) - send hook usage tracking data to metrics gathering site

### Linters

* [go-lint](https://github.com/golang/lint) - linter for Golang code, concerned mainly with coding style
* [go-vet](https://golang.org/cmd/vet/) - linter for Golang code, concerned mainly with code correctness
* [shellcheck](https://github.com/koalaman/shellcheck) - tool that gives warnings and suggestions for Bash/sh shell scripts
* [swiftlint](https://github.com/realm/SwiftLint) - enforces Swift style and conventions, loosely based on [GitHub's Swift Style Guide](https://github.com/github/swift-style-guide)

### Autoformatters

* [go-fmt](https://golang.org/cmd/gofmt/) - formats Golang programs
* [shfmt](https://github.com/mvdan/sh#shfmt) - formats shell programs
