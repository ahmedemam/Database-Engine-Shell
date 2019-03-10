#!/usr/bin/env bash
#. Create Database
#. Parameters - Database Name
function create_database() {
        if [[ ! -d "${DATABASES_DIRECTORY}/$1" ]]; then
            mkdir "${DATABASES_DIRECTORY}/$1"
            GLOBAL_MESSAGE="#> $1 DATABASE CREATED SUCCESSFULLY."
            echo "${GLOBAL_MESSAGE}"
        else
            GLOBAL_EXCEPTION="#> $1 DATABASE EXIST."
            echo "${GLOBAL_EXCEPTION}"
        fi
            read_commands
}

