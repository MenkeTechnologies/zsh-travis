```
 ____ ____  _   _    _____ ____    ___     _____ ____
|_  /|  __|| | | |  |_   _|  _ \  / \ \   / |_ _/ ___|
 / / | |   | |_| |    | | | |_) || _ \\ \ / / | |\___ \
/ /__| |___|  _  |    | | |  _ < | |_| |\ V /  | | ___) |
\____\____||_| |_|    |_| |_| \_\|_| |_| \_/  |___|____/
```

<p align="center">
<code>// `tg`, `tb`, `tbr`, `tpr` — TRAVIS CI BUILD PAGES, ONE KEYSTROKE.</code>
</p>

### [`Read the Docs`](https://menketechnologies.github.io/zsh-travis/) &middot; [`Engineering Report`](https://menketechnologies.github.io/zsh-travis/report.html)

---

[![Aliases](https://img.shields.io/badge/aliases-4-ff2a6d.svg)](zsh-travis.plugin.zsh)
[![Tag](https://img.shields.io/badge/tag-v0.1.0-39ff14.svg)](https://github.com/MenkeTechnologies/zsh-travis/tags)
[![Shell](https://img.shields.io/badge/shell-zsh-05d9e8.svg)](#install)
[![Trigger](https://img.shields.io/badge/needs-.travis.yml-d300c5.svg)](#system-overview)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](license.md)

### `[SIGNAL // OPEN THE TRAVIS BUILD PAGE FROM WITHIN THE PROJECT]`

> *// `cd` into a Travis-tracked project, type `tb`, the build log opens. NO TAB-SWITCHING. NO URL-PASTING. //*

---

## `> SYSTEM OVERVIEW`

`zsh-travis` adds four functions + four aliases for opening Travis CI pages directly from the project directory. Detects `.travis.yml`, reads `git config --get remote.origin.url` for the upstream, and `open`s the right Travis URL — main, branch, build, or PR.

Pairs with [`gh_reveal`](https://github.com/MenkeTechnologies/gh_reveal) and the rest of the [zpwr](https://github.com/MenkeTechnologies/zpwr) plugin chain.

---

## `> COMMANDS`

```
tg       trav-git           open the project's main Travis CI page
tb       trav-git-build     open the latest build log
tbr      trav-git-br        open the current-branch builds
tpr      trav-git-pr        open the open PR builds
```

All four print `No .travis.yml file found.` to stderr if `.travis.yml` is absent — safe to bind globally.

---

## `> INSTALL`

### Zinit

```sh
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-travis
```

### Oh My Zsh

```sh
cd "$HOME/.oh-my-zsh/custom/plugins" && \
  git clone https://github.com/MenkeTechnologies/zsh-travis.git
```

Add `zsh-travis` to the `plugins=(...)` array in `~/.zshrc`.

### Manual

```sh
git clone https://github.com/MenkeTechnologies/zsh-travis.git
source zsh-travis/zsh-travis.plugin.zsh
```

---

## `> LICENSE`

[MIT](license.md)

---

<p align="center">
<code>// END OF FILE // BUILD LOG LOCKED //</code>
</p>
