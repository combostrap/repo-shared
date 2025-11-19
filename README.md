# Repo Manager: Dynamic Repository Management

## About

This repository helps to init and update git combostrap repositories.

## Concept / How it works

It uses the following software to manage common repositories stuff:

* [copier](https://copier.readthedocs.io/) for project templating and upgrade
* [direnv](https://direnv.net/) for project setup and environment
* [pre-commit](https://pre-commit.com/) for files check and normalization
* [bin](bin) scripts are made available by [cloning this repo](#scripts-in-path) and putting them in the `PATH`.

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
* [install, configure and sync the repo](#scripts-in-path)

If you open your terminal, `direnv` should execute `.envrc`.
If not:

```bash
direnv reload
```


## Features and configuration

### Git User Configuration

To set the git user, you can set in your `.bashrc` the following env:

| Env                                    |
|----------------------------------------|
| `GIT_${ORGANIZATION_NAME}_EMAIL`       |
| `GIT_${ORGANIZATION_NAME}_SIGNING_KEY` |

See the [Git User Configuration Script](bin/git-config-user)

### Editor Config for code styling

Install the [root editor config](copier-template/.editorconfig)

### Copy .gitignore and .gitattributes if not found

Default  [.gitignore](copier-template/.gitignore) and [.gitattributes](copier-template/.gitattributes) are installed

### Create a LICENSE

A License is installed

### Project only env configuration (direnv.d)

For project only configuration, you can add your own `direnv` scripts in the `PROJECT_ROOT/direnv.d` directory.
All `.sh` files present in this directory will be sourced.

In your scripts, you can use the following env:

| Syntax                  | Description                                                          |
|-------------------------|----------------------------------------------------------------------|
| `PROJECT_ROOT`          | The root directory of the git repo (ie `GIT_ROOT` without submodule) |
| `ORGANISATION_ENV_NAME` | The organization name in an env format                               |

### Scripts in PATH

Install this repository by cloning it and put the common [scripts](bin) in the `PATH`

You can change the behavior of the [envrc](copier-template/.envrc.jinja) resource manager script by setting the following variable in
your shell profile, `~/.bashrc`, or `~/.config/direnv/direnvrc`, or `~/.envrc.local`.


| Environment | Default  Value                             | Description                                                             |
|-------------|--------------------------------------------|-------------------------------------------------------------------------|
| `RM_DIR`    | `$PROJET_ROOT/../repo-manager`             | The local file system location of the resource manager repository clone |
| `RM_URI`    | https://github.com/combostrap/repo-manager | The URI location of the resource manager repository                     |

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

You can update this repo to the last copier template with:
```bash
task update
# equivalent to
copier update .
```
