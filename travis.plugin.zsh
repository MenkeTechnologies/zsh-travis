(( $+functions[getOpenCommand] )) ||
getOpenCommand(){
    local open_cmd

    case "$ZPWR_OS_TYPE" in
        darwin*)  open_cmd='open'
          ;;
        cygwin*)  open_cmd='cygstart'
          ;;
        linux*)
            if [[ "$(uname -r)" != *icrosoft* ]];then
                open_cmd='nohup xdg-open'
            else
                open_cmd='cmd.exe /c start ""'
            fi
            ;;
        msys*)    open_cmd='start ""'
            ;;
        *)        echo "Platform $ZPWR_OS_TYPE not supported"
                    return 1
                    ;;
    esac

    echo "$open_cmd"
}

if [[ -z "$ZPWR_OPEN_CMD" ]]; then
    ZPWR_OPEN_CMD="$(getOpenCommand)"
fi


function __trav_open() {

    ${=ZPWR_OPEN_CMD} "$1" 2>/dev/null
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
alias tb=trav-git-build
alias tbr=trav-git-br
alias tpr=trav-git-pr
