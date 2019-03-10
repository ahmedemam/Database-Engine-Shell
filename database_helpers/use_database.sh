#!/usr/bin/env bash


#. Use Database
#. Parameters - Database Name
function use_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        directory=${DATABASES_DIRECTORY}/$1
        cd $directory
        GLOBAL_MESSAGE="#> \e[32m$1 DATABASE SELECTED SUCCESSFULLY.\e[93m\n"
        printf "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="#> \e[41m$1 DATABASE NOT EXIST.\e[49m\n"
        printf "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}

