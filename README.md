# Repo Manager (repm): Dynamic Repository Management

## About

This repository helps to init and update git combostrap repositories.

## Concept / How it works

It uses the following software to manage common repositories stuff:

* [copier](https://copier.readthedocs.io/) for project templating and upgrade
* [direnv](https://direnv.net/) for project setup and environment
* [pre-commit](https://pre-commit.com/) for files check and normalization
* [common scripts](#common-scripts)  are made available by cloning this repo and putting them in the `PATH`.

## Where are the artifacts

* The `copier` template is located at [copier template](copier-template)
* The `pre-commit`
  * config is part of the template at [.pre-commit-config.yaml](copier-template/.pre-commit-config.yaml)
  * setup is performed with direnv via [.envrc](copier-template/.envrc.jinja)
  * extra `git hooks` are available at [git-hooks](git-hooks)
* The common dev scripts are in the [bin](bin)

## Steps

### Prerequisites

Install:

* [copier](https://copier.readthedocs.io/en/stable/#installation)
* [direnv](https://direnv.net/docs/installation.html)
* [pre-commit](https://pre-commit.com/#install)
* [task](https://taskfile.dev/docs/installation) `optional`

### Copy or update this copier template

* for a new git repo

```bash
cd your_repo
git init
copier copy https://github.com/combostrap/repo-manager .
```

* to update a git repo

```bash
copier update .
```

### Setup and local configuration

The [.envrc](copier-template/.envrc.jinja) file is the main entry for `setup` and local config.

It will:

* install the git hooks with `pre-commit`
* [install the common scripts](#common-scripts)

If you open your terminal, `direnv` should execute `.envrc`.
If not:

```bash
direnv reload
```

## Features and configuration

### Git User Configuration

To set the git user, you can set in your `.bashrc` the following env:

| Env                                     |
|-----------------------------------------|
| `REPM_${ORGANIZATION_NAME}_EMAIL`       |
| `REPM_${ORGANIZATION_NAME}_SIGNING_KEY` |

See the [Git User Configuration Script](bin/git-config-user)

### Editor Config for code styling

Install the [root editor config](copier-template/.editorconfig)

### Copy .gitignore and .gitattributes if not found

Default  [.gitignore](copier-template/.gitignore) and [.gitattributes](copier-template/.gitattributes) are installed

### Create a LICENSE

A License is installed

### Scripts

#### Project only scripts (direnv.d)

For project only configuration, you can add your own `direnv` scripts in the `PROJECT_ROOT/direnv.d` directory.
All `.sh` files present in this directory will be sourced.

#### Common Scripts

Common scripts located in the [bin](bin) directory are made available:

* by cloning this repo
* and put the [bin](bin) in the `PATH`

The code is in the [envrc](copier-template/.envrc.jinja) and can be configured by setting the
following variable in your shell profile, `~/.bashrc`, or `~/.config/direnv/direnvrc`, or `~/.envrc.local`.

| Environment | Default  Value                             | Description                                                             |
|-------------|--------------------------------------------|-------------------------------------------------------------------------|
| `REPM_DIR`  | `$PROJET_ROOT/../repo-manager`             | The local file system location of the resource manager repository clone |
| `REPM_URI`  | https://github.com/combostrap/repo-manager | The URI location of the resource manager repository                     |

#### Scripts Environment variable

In your scripts, you can use the following env:

| Syntax                   | Description                                                          |
|--------------------------|----------------------------------------------------------------------|
| `PROJECT_ROOT`           | The root directory of the git repo (ie `GIT_ROOT` without submodule) |
| `ORGANISATION_NAME`      | The organization name                                                |
| `ORGANISATION_ENV_NAME`  | The organization name in a env format                                |
| `ORGANISATION_PATH_NAME` | The organization name in a file path format                          |

### Prepare your next commit

You can check the files in you next commit with:

```bash
task prepare
# equivalent to
git add -A && pre-commit run
# or with the common dev script
git-prepare
```

### Repository update

You can update any repo generated to the last copier template with:

```bash
task update
# equivalent to
copier update .
```
