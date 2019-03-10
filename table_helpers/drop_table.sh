#!/usr/bin/env bash

function drop_table () {
    commands=( $(echo "$1") )
    if [[ ${commands[1]} == "TABLE" ]] && [[ ${commands[2]} ]] && [[ ! ${commands[3]} ]]
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        if [[ ! -d ${table_name} ]]
        then
            `rm ${table_name}`
            `rm ${table_meta}`
        fi
    else
        printf "#> \e[38;5;196mSyntax error: DROP TABLE table_name\e[49m\n"
    fi
    read_commands
}