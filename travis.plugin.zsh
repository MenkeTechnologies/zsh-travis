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


alias tg=trav-git
alias tb=trav-git-build
alias tbr=trav-git-br
alias tpr=trav-git-pr

0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# util fns
fpath+=("${0:h}/autoload")
autoload -Uz "${0:h}/autoload/"*(.:t)
