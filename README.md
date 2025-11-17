# Repo Manager: Dynamic Git Repository Configuration

## About

Manage, init and update the common stuff on all your Git repositories.

## Concept / How it works

The [envrc](envrc/.envrc) file is the main entry

* Once [installed](#how-to-install-it-in-a-git-repo), it will clone the `repo manager` repo if not found
* [install, configure and sync the repo](#what-are-the-repo-configurations)
* and update itself if needed

## How to install it in a git repo

Prerequisite: [direnv](https://direnv.net/) should be installed on your computer.

Then:

```bash
# Init a repo if you don't have one
git init
# Install repo manager
curl -O https://raw.githubusercontent.com/combostrap/repo-manager/refs/heads/main/envrc/.envrc
# Type enter to kick direnv in or reload
direnv reload
```

## What are the repo configurations?

### Git User Configuration

To set the git user, you can set in your `.bashrc` the following env:

| Env with Organization                 | Env Without Organization |
|---------------------------------------|--------------------------|
| `RM_${ORGANIZATION_NAME}_EMAIL`       | `RM_EMAIL`               |
| `RM_${ORGANIZATION_NAME}_SIGNING_KEY` | `RM_SIGNING_KEY`         |

See the [Git User Configuration Script](git/config/user)

### Git Hooks Configuration and installation

The git hooks directory is configured to `.git-hooks` (See [Git Hooks configuration scripts](git/config/hooks))

And the following hooks are synced in it:

* [commit message hook](git/hooks/commit-msg/commit-lint) - for commit lint check
* [pre-commit](git/hooks/pre-commit/out-of-sync) - to check for out of sync branch

### Scripts in PATH

Install the common [scripts](bin) in the `PATH`

### Editor Config for code styling

Install the [root editor config](copier/.editorconfig)

### Copy .gitignore and .gitattributes if not found

Default  [.gitignore](git/ignore/.gitignore) and [.gitattributes](git/ignore/.gitattributes) are installed if not found.

### Create a Default LICENSE

Default License is installed if not found

### Project only env configuration (direnv.d)

For project only configuration, you can add your own `direnv` scripts in the `PROJECT_ROOT/direnv.d` directory.
All `.sh` files present in this directory will be sourced.

In your scripts, you can use the following env:

| Syntax                  | Description                                                          |
|-------------------------|----------------------------------------------------------------------|
| `PROJECT_ROOT`          | The root directory of the git repo (ie `GIT_ROOT` without submodule) |
| `ORGANISATION_ENV_NAME` | The organization name in an env format                               |
| `RM_PREFIX`             | The resource manager prefix (ie `RM`)                                |

## Repo Manager Customization / Environment

You can change the behavior of the [envrc](envrc/.envrc) resource manager script by setting the following variable in
your shell profile, `~/.bashrc`, or `~/.config/direnv/direnvrc`, or `~/.envrc.local`.

The `ORGANISATION_NAME` variable is optional.

| Environment                                    | Default  Value                             | Description                                                             |
|------------------------------------------------|--------------------------------------------|-------------------------------------------------------------------------|
| `RM_${ORGANIZATION_NAME}_DIR` <BR> or `RM_DIR` | `$PROJET_ROOT/../repo-manager`             | The local file system location of the resource manager repository clone |
| `RM_${ORGANIZATION_NAME}_URI` <BR> or `RM_URI` | https://github.com/combostrap/repo-manager | The URI location of the resource manager repository                     |

## Contrib

You can fork this repo and

* make it your own
* or create a pull request to contribute

