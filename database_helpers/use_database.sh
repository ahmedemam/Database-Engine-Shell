#!/usr/bin/env bash


#. Use Database
#. Parameters - Database Name
function use_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        directory=${DATABASES_DIRECTORY}/$1
        cd $directory
        `pwd`
        GLOBAL_MESSAGE="#> $1 DATABASE SELECTED SUCCESSFULLY."
        echo "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="#> $1 DATABASE NOT EXIST."
        echo "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}

