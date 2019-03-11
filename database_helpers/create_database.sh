#!/usr/bin/env bash
#. Create Database
#. Parameters - Database Name
function create_database() {
        if [[ ! -d "${DATABASES_DIRECTORY}/$1" ]]; then
            mkdir "${DATABASES_DIRECTORY}/$1"
            GLOBAL_MESSAGE="#> \e[30;48;5;28m$1 DATABASE CREATED SUCCESSFULLY.\e[49m\n"
            printf "${GLOBAL_MESSAGE} \n"
        else
            GLOBAL_EXCEPTION="#> \e[48;5;124m$1 DATABASE EXIST.\e[49m\n"
            printf "${GLOBAL_EXCEPTION}"
        fi
            read_commands
}

