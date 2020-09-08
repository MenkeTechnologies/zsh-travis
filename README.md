# zsh-travis

ZSH plugin to open Travis CI .com page for the current repo (if .travis.yml exists).

## Functions

```sh
trav-git # open travis main page
trav-git-br# open travis branch page
trav-git-build # open travis build page
trav-git-pr # open travis PR page
```

## Aliases

```sh
alias tg=trav-git
alias tb=trav-git-build
alias tbr=trav-git-br
alias tpr=trav-git-pr
```

## Install for Zinit
> `~/.zshrc`
```sh
source "$HOME/.zinit/bin/zinit.zsh"
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-travis
```

## Install for Oh My Zsh

```sh
cd "$HOME/.oh-my-zsh/custom/plugins" && git clone https://github.com/MenkeTechnologies/zsh-travis.git
```

Add `zsh-travis` to plugins array in ~/.zshrc

