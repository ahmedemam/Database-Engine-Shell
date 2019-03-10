#!/usr/bin/env bash

#. Drop Database
#. Parameters - Database Name
function drop_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        rm -r "${DATABASES_DIRECTORY}/$1"
        GLOBAL_MESSAGE="#> \e[42m $1 DATABASE DROPPED SUCCESSFULLY.\e[49m\n"
        printf "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="#> \e[41m $1 DATABASE NOT EXIST.\e[49m\n"
        printf "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}
