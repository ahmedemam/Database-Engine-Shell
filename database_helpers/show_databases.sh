#!/usr/bin/env bash


#. Show Databases
#. Parameters - No Parameters - Just Call
function show_databases() {
    if [[ -d "${DATABASES_DIRECTORY}" ]]; then
        printf '#> DATABASES: \n'
        for database_dir in ${DATABASES_DIRECTORY}/* ; do
            if [[ -d ${database_dir} ]]; then
                printf ".> \e[38;5;82m${database_dir##*/}\e[49m\n"
            fi
        done
    else
        GLOBAL_EXCEPTION="#> \e[38;5;160mSORRY, NO DATABASES YET.\e[49m\n"
        printf "${GLOBAL_EXCEPTION}"
    fi
    read_commands
}
