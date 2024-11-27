# dotfiles
@mgaffney dotfiles

## New Mac Setup

1. Install Xcode Command Line Tools

```bash
xcode-select --install
```

2. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

3. Clone dots repo

```bash
git clone https://github.com/mgaffney/dotfiles.git
```

4. Install Brewfile

```bash
cd dotfiles
brew bundle install
``` 

5. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

6. Run dotfiles install script

```bash
./install.sh
```
