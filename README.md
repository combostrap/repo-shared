# Repo Shared Scripts and Configuration


## About
Common scripts and configuration used in Combostrap repositories

Each repository has a [.envrc](.envrc) file that is leading.

The [.envrc](.envrc) installs from this repository what it needs.

## Steps


### Step 1 - Project Environment

Project Environment are common project variables

In [.envrc](.envrc)
```bash
echo "Project: "
export PROJECT_ORGANISATION_NAME="combostrap"
echo "   Organization Name : $PROJECT_ORGANISATION_NAME"
export PROJECT_ROOT="$PWD"
echo "   Project Root      : $PROJECT_ROOT"
```


### Install/Setup

The installation is done by cloning the repo to a well-known location.
By default, this location is `$PWD/../repo-shared`

Example Script in [.envrc](.envrc)
```bash
SHARED_REPO_DIR_VAR_NAME="GIT_${PROJECT_ORGANISATION_NAME}_SHARED_REPO_DIR"
SHARED_REPO_DIR=$(realpath "${!SHARED_REPO_DIR_VAR_NAME:-$PWD/../repo-shared}")
if [ ! -d "$SHARED_REPO_DIR" ]; then

    function echo::warning(){
        YELLOW="\033[0;33m"
        NO_COLOR="\033[0m"
        echo -e "${YELLOW}Warning: $1$NO_COLOR"
    }

    SHARED_REPO_URI_VAR_NAME="GIT_${PROJECT_ORGANISATION_NAME}_SHARED_REPO_URI"
    SHARED_REPO_URI="${!SHARED_REPO_URI_VAR_NAME:-https://github.com/combostrap/repo-shared}"
    echo::warning "Shared repo installation"
    echo::warning "Clone $URL to $SHARED_REPO_DIR? Y(Yes-Default)/N(No)"
    read -r CLONE
    if [ "$CLONE" == "" ] || [ "$CLONE" == "Y" ]; then
        git clone "$SHARED_REPO_URI" "$SHARED_REPO_DIR"
        echo::warning "Shared repo cloned"
    fi

fi
````


### Git User Config

Git user config to set the user email and name.

in [.envrc](.envrc)
```bash
$SHARED_REPO_DIR/git/config/user
```

### Git Hooks

Git hooks configuration

in [.envrc](.envrc)
```bash
GIT_HOOKS="$PROJECT_ROOT/.git-hooks"
$SHARED_REPO_DIR/git/config/hooks "$GIT_HOOKS"
```

Install commit message hook:
```bash
rsync "$SHARED_REPO_DIR/git/hooks/commit-msg" "$GIT_HOOKS/commit-msg"
```

### Scripts

Scripts in the path

In [.envrc](.envrc)
```bash
export PATH="$PATH:$SHARED_REPO_DIR/bin"
```

### Editor Config

For code styling

root installation in [.envrc](.envrc)
```bash
rsync $SHARED_REPO_DIR/editorconfig/root/.editorconfig $PROJECT_ROOT/.editorconfig
```

Check that editor config is enabled in your IDE.
* [Idea Intellij](https://www.jetbrains.com/help/idea/editorconfig.html#disable-editorconfig)
