#!/usr/bin/env zunit
#{{{                    MARK:Header
#**************************************************************
##### Purpose: alias + fn pins for zsh-travis. Plugin registers
#####          tb/tbr/tg/tpr aliases over the 4 trav-git-* fns that
#####          open Travis CI pages for the current repo.
#}}}***********************************************************

@setup {
    0="${${0:#$ZSH_ARGZERO}:-${(%):-%N}}"
    0="${${(M)0:#/*}:-$PWD/$0}"
    pluginDir="${0:h:A}"
}

@test 'tg alias is short for trav-git (main project page)' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias tg
    ")
    assert "$body" contains 'trav-git'
}

@test 'tb alias is short for trav-git-build' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias tb
    ")
    assert "$body" contains 'trav-git-build'
}

@test 'tbr alias is short for trav-git-br (branch page)' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias tbr
    ")
    assert "$body" contains 'trav-git-br'
}

@test 'tpr alias is short for trav-git-pr (PR builds page)' {
    local body
    body=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias tpr
    ")
    assert "$body" contains 'trav-git-pr'
}

@test 'all 4 trav-git-* helper fns are defined' {
    for fn in trav-git trav-git-build trav-git-br trav-git-pr; do
        local out
        out=$(zsh -c "
            emulate zsh
            source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
            typeset -f $fn >/dev/null && echo defined
        ")
        assert "$out" same_as 'defined'
    done
}

@test 'helper fn getOpenCommand is defined (cross-platform browser opener)' {
    local out
    out=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        typeset -f getOpenCommand >/dev/null && echo defined
    ")
    assert "$out" same_as 'defined'
}

@test 'plugin sourcing is idempotent — same alias count after re-source' {
    local first second
    first=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias | grep -cE '^t[a-z]+='
    ")
    second=$(zsh -c "
        emulate zsh
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        source '$pluginDir/zsh-travis.plugin.zsh' 2>/dev/null
        alias | grep -cE '^t[a-z]+='
    ")
    assert "$first" equals "$second"
}
