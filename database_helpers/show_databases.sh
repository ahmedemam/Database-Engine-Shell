#!/usr/bin/env bash


#. Show Databases
#. Parameters - No Parameters - Just Call
function show_databases() {
    if [[ -d "${DATABASES_DIRECTORY}" ]]; then
        echo '#> DATABASES'
        for database_dir in ${DATABASES_DIRECTORY}/* ; do
            if [[ -d ${database_dir} ]]; then
                echo ".> ${database_dir##*/}"
            fi
        done
    else
        GLOBAL_EXCEPTION="${GLOBAL_EXCEPTION}SORRY, NO DATABASES YET."
        echo "${GLOBAL_EXCEPTION}"
    fi
}
show_databases