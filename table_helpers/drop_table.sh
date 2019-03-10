#!/usr/bin/env bash

function drop_table () {
    commands=( $(echo "$1") )
    if [[ ${commands[1]} == "TABLE" ]] && [[ ${commands[2]} ]] && [[ ! ${commands[3]} ]]
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        `rm ${table_name}`
        `rm ${table_meta}`
    else
        printf "#> \e[41mSyntax error: DROP TABLE table_name\e[49m\n"
    fi
    read_commands
}