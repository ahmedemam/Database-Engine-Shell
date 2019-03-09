#!/usr/bin/env bash
function start_bash_prompt () {
    export PS1="\[\e[0;1;35m\database_engine_shell\[\e[0;1;36m\] >> \[\e[0m\]"
    export PS2="\[\e[0;1;36m\] >> \[\e[0m\]"
}
function end_bash_prompt () {
    exec bash
}

