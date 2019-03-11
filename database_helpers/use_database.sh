#!/usr/bin/env bash
#. Use Database
#. Parameters - Database Name
function use_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        directory=${DATABASES_DIRECTORY}/$1
        cd $directory
        DATABASE_CURSOR="IN> $1> "
        GLOBAL_MESSAGE="\e[30;48;5;28m$1 DATABASE SELECTED SUCCESSFULLY.\e[49m\n"
        printf "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="#> \e[48;5;124m$1 DATABASE NOT EXIST.\e[49m\n"
        printf "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}

