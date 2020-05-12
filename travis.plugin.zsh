#!/bin/zsh
function __trav_open() {

    ${=ZPWR_OPEN_CMD} "$1"
}

function __trav_check_yml() {
  trav_file="$(git rev-parse --show-toplevel)/.travis.yml"
  test -f $trav_file || return 1
}

function __trav_common_url(){

  repo_url=$(git config --get remote.origin.url)
  branch=$(git rev-parse --abbrev-ref HEAD)
  url="${repo_url/https:\/\//}"
  url="${url/http:\/\//}"
  url="${url/ssh:\/\//}"
  url="${url/git:\/\//}"
  url="${url/.com/}"
  url="${url/.git/}"
  url="$url$1"
}

function __trav_get_url() {
    __trav_common_url "$@"
  url="https://travis-ci.org/$url"
}

function __trav_get_priv_url() {
    __trav_common_url "$@"
    url="https://travis-ci.com/$url"
}

function trav-git() {
  if __trav_check_yml; then
    __trav_get_url "$@"
    __trav_open $url
  else
    echo "No .travis.yml file found." >&2
  fi
}

function trav-priv-git() {
  if __trav_check_yml; then
    __trav_get_priv_url "$@"
    __trav_open $url
  else
    echo "No .travis.yml file found." >&2
  fi
}

function trav-priv-git-br() {
    trav-priv-git "/branches"
}

function trav-priv-git-pr() {
    trav-priv-git "/pull_requests"
}

function trav-priv-git-build() {
    trav-priv-git "/builds"
}

alias tg=trav-priv-git
alias tgb=trav-priv-git-build
alias tgbr=trav-priv-git-br
alias tgpr=trav-priv-git-pr
