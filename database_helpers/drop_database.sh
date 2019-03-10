#!/usr/bin/env bash

#. Drop Database
#. Parameters - Database Name
function drop_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        rm -r "${DATABASES_DIRECTORY}/$1"
        GLOBAL_MESSAGE="#> $1 DATABASE DROPPED SUCCESSFULLY."
        echo "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="#> $1 DATABASE NOT EXIST."
        echo "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}
