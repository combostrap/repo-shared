# Devfiles - Dev flow configuration across Git repositories

## About

This repository contains [devfiles](#what-are-devfiles).

We use them to manage centrally and distribute our development flow and environment across Git repositories.

## What are devfiles?

`dotfiles` configure application files, `devfiles` configure a development flow.

With them, you can:

* init/scaffold a new repo
* update an existing one to the latest `devfiles`

and get instantly a consistent development environment across your git repositories.


## QuickStart in three commands

In a new or existing git repository, execute the following commands to install the [devfiles](#what-are-devfiles):
```bash
cd your-git-repo
copier copy https://github.com/combostrap/devfiles .
direnv reload
```

For a step by step, see [the detailed steps](#steps)

## How it works

### Core Component

It uses the following core components:

* [copier](#copy-or-update-this-copier-template) for `devfiles` installation and upgrade
* [direnv](#setup-and-local-configuration-direnv) for setup (project and environment)
* [dev scripts](#dev-scripts) for development flow

### Utility components

The utility components are used in the [scripts](#dev-scripts) or as configuration:

* [pre-commit](https://pre-commit.com/) for files check and normalization
* [jreleaser](#jreleaser ) for release management
* [pass](#pass---local-secret-management) for secrets management
* [git-cliff](https://git-cliff.org/) for change log and version bump
* [go task](#task-distribution) for common tasks distribution
* [editorconfig](#code-styling-editor-config) for code styling
* [commitlint](#commit-message-validation-commitlint) for commit message validation
* [markdown-link-check](#markdown-link-check) for Markdown link validation

## Steps

### Prerequisites

Install:

* [copier](https://copier.readthedocs.io/en/stable/#installation)
* [direnv](https://direnv.net/docs/installation.html)
* [pre-commit](https://pre-commit.com/#install)
* [task](https://taskfile.dev/docs/installation) `optional`

### Copy or update this copier template

* to install the latest `devfiles` in a git repo (empty or not)

```bash
# Optionally cd your_repo && git init
copier copy https://github.com/combostrap/devfiles .
```

* to update a git repo with the last `devfiles` version

```bash
copier update .
```

Note: the `copier template` is in the [copier-template directory](copier-template)

### Setup and local configuration (direnv)

The [.envrc](copier-template/.envrc.jinja2) file is the main entry for `setup` and local config.

It will:

* install the git hooks with [pre-commit](#git-hooks-and-pre-commit)
* [install the dev scripts](#dev-scripts)

If you open your terminal, `direnv` should execute `.envrc`.
If not:

```bash
direnv reload
```

## Features and configuration




### Pass - Local Secret Management

Pass ([pass](https://www.passwordstore.org/) or [gopass](https://www.gopass.pw/)) is used for secret management.

All secrets are located under the organization name.

Example for a GitHub token:

```bash
pass "$ORGANISATION_PATH_NAME/github/release-token"
```

Note:
* The secrets are not stored as global shell variables.
* They are retrieved in wrapper script that wraps a command.
* They are therefore only available while running the wrapper script.

Example of wrappers:

* [jreleaser](dev-scripts/wrapper/jreleaser)
* [mvnw (maven)](dev-scripts/package-manager/maven/mvnw)

### JReleaser

For release management, we use [jreleaser](https://jreleaser.org/).

We distribute with this template, a [jreleaser](dev-scripts/wrapper/jreleaser) wrapper script
to pass the needed secrets with [pass](#pass---local-secret-management)

### Git User Configuration

To set the git user, you can set in your `.bashrc` the following env:

| Env                                     |
|-----------------------------------------|
| `DEVF_${ORGANIZATION_NAME}_EMAIL`       |
| `DEVF_${ORGANIZATION_NAME}_SIGNING_KEY` |

See the [Git User Configuration Script](dev-scripts/setup/git-config.sh)

### Code Styling (Editor Config)

The [editorconfig](https://editorconfig.org/) file is [.editorconfig](copier-template/.editorconfig)

We also use the following `editorconfig` code styling utility:
  * [shfmt](https://github.com/patrickvane/shfmt) for bash styling
  * [editorconfig-checker)](https://github.com/editorconfig-checker/editorconfig-checker) as [hook](#git-hooks-and-pre-commit)


### Commit Message Validation (CommitLint)

[commitlint](https://commitlint.js.org/) configuration is located
at [commitlint.config.js](copier-template/.config/commitlint.config.js)

### Markdown Link-Check

[markdown-link-check](https://github.com/tcort/markdown-link-check) for Markdown link validation
configuration is located at [markdown-link-check.config.json](copier-template/.config/markdown-link-check.config.json)

### Copy .gitignore and .gitattributes if not found

Default  [.gitignore](copier-template/.gitignore) and [.gitattributes](copier-template/.gitattributes) are installed

### Create a LICENSE file

A `LICENSE` file is created from the following templates:
  * [Apache 2.0](copier-template/%7B%25%20if%20license_type%20==%20'Apache-2.0'%20%25%7DLICENSE%7B%25%20endif%20%25%7D.jinja2)
  * [MIT](copier-template/%7B%25%20if%20license_type%20==%20'MIT'%20%25%7DLICENSE%7B%25%20endif%20%25%7D.jinja2)
  * [FSL](copier-template/%7B%25%20if%20license_type%20==%20'FSL-1.1-ALv2'%20%25%7DLICENSE.md%7B%25%20endif%20%25%7D.jinja2)

### Scripts

#### Project only scripts (direnv.d)

For project only configuration, you can add your own `direnv` scripts in the `PROJECT_ROOT/direnv.d` directory.
All `.sh` files present in this directory will be sourced.

#### Dev Scripts

Dev scripts located in the [dev-scripts](dev-scripts) directory.

They are made available:

* by cloning this repository
* and put in the `PATH`:
  * the [git-hooks scripts directory](#git-hooks-and-pre-commit)
  * the [package-manager scripts](dev-scripts/package-manager)
  * the [setup scripts directory](dev-scripts/setup)
  * the [wrapper scripts directory](#pass---local-secret-management)

The code is in the [envrc](copier-template/.envrc.jinja2) and can be configured by setting the
following variable in your shell profile, `~/.bashrc`, or `~/.config/direnv/direnvrc`, or `~/.envrc.local`.

| Environment                     | Default  Value                         | Description                                                     |
|---------------------------------|----------------------------------------|-----------------------------------------------------------------|
| `DEVF_${ORGANIZATION_NAME}_DIR` | `$PROJET_ROOT/../devfiles`             | The local file system location of the devfiles repository clone |
| `DEVF_${ORGANIZATION_NAME}_URI` | https://github.com/combostrap/devfiles | The URI location of the devfiles repository                     |

#### Scripts Environment variable

In your scripts, you can use the following env:

| Syntax                   | Description                                                          |
|--------------------------|----------------------------------------------------------------------|
| `PROJECT_ROOT`           | The root directory of the git repo (ie `GIT_ROOT` without submodule) |
| `ORGANISATION_NAME`      | The organization name                                                |
| `ORGANISATION_ENV_NAME`  | The organization name in a env format                                |
| `ORGANISATION_PATH_NAME` | The organization name in a file path format                          |

### Git Hooks and Pre-commit

The `pre-commit`:

* config is part of the template at [.pre-commit-config.yaml](copier-template/.pre-commit-config.yaml.jinja2)
* setup is performed with direnv via [.envrc](copier-template/.envrc.jinja2)
* extra `git hooks` are available at [git-hooks](dev-scripts/git-hooks)

### Prepare your next commit

You can check the files in you next commit with:

```bash
task prepare
# equivalent to
git add -A && pre-commit run
# or with the common dev script
git-prepare
```

### Task Distribution

The [go task](https://github.com/go-task/task) file is [Taskfile.yaml](copier-template/Taskfile.yaml.jinja2)

## How to

### How to update the devfiles to the latest version?

You can update any repo generated to the last `devfiles` with:

```bash
task update
# or/equivalent to
copier update .
```

## Contrib

How to develop and contrib to this repository. See [contrib](contrib.md)
