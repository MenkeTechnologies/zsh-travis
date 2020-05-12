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
    tempurl="https://travis-ci.com/$url"
    if curl -s --head  --request GET $tempurl | grep "404 Not Found" > /dev/null;then
        finalurl="https://travis-ci.org/$url"
    else
        finalurl="$tempurl"

    fi

}

function trav-git() {
  if __trav_check_yml; then
    __trav_get_url "$@"
    __trav_open $finalurl
  else
    echo "No .travis.yml file found." >&2
  fi
}

function trav-git-br() {
    trav-git "/branches"
}

function trav-git-pr() {
    trav-git "/pull_requests"
}

function trav-git-build() {
    trav-git "/builds"
}

alias tg=trav-git
alias tgb=trav-git-build
alias tgbr=trav-git-br
alias tgpr=trav-git-pr
