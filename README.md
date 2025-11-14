# Repo Shared Scripts and Configuration


## About
Common scripts and configuration used in Combostrap repositories

## Usage Steps

### Add it as submodule

Add it as submodule in your repo

```bash
git submodule add --name repo-shared https://github.com/combostrap/repo-shared.git .repo-shared
```

### Add it as Git directory in your IDE

Optional, needed only if you want to commit to it from a submodule.

Because it's a config/hidden directory, IDE may not see them.

In Idea, you need to add the directory mapping (Settings > Version Control > Directory mapping)
because Intellij will not discover it automatically.


### Project Env

Project Env in [.envrc](.envrc) (used in scripts)
```bash
echo "Project: "
export PROJECT_ORGANISATION_NAME="combostrap"
echo "   Organization Name : $PROJECT_ORGANISATION_NAME"
export PROJECT_ROOT="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "   Project Root      : $PROJECT_ROOT"
```

### Git Config

git config in [.envrc](.envrc)
```bash
.repo-shared/git/config
```

### Maven scripts

Maven scripts in [.envrc](.envrc)
```bash
export PATH="$PATH:$PWD/.repo-shared/maven"
```

### Editor Config

For code styling in [.envrc](.envrc)
```bash
rsync $PWD/.repo-shared/editorconfig/root/.editorconfig $PWD/.editorconfig
```

Check that editor config is enabled in your IDE.
* [Idea Intellij](https://www.jetbrains.com/help/idea/editorconfig.html#disable-editorconfig)
