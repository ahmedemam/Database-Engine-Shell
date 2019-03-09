#!/usr/bin/env bash

# Root Home Directory
ROOT_HOME_DIRECTORY="$HOME/Database_Engine_Shell_Source/"
# Database Directory
DATABASES_DIRECTORY="${ROOT_HOME_DIRECTORY}Databases"
# Users Database List File
USERS_FILES_PRIVILEGES="$ROOT_HOME_DIRECTORY/users_data"
# Global Error/Exception
GLOBAL_EXCEPTION='> exception:'
GLOBAL_MESSAGE='> '
# Database Use/In Now
DATABASE_CURSOR=''



#. Drop Database
#. Parameters - Database Name
function drop_database() {
    if [[ -d "${DATABASES_DIRECTORY}/$1" ]]; then
        rm -r "${DATABASES_DIRECTORY}/$1"
        GLOBAL_MESSAGE="${GLOBAL_MESSAGE} $1 DATABASE DROPPED SUCCESSFULLY."
        echo "${GLOBAL_MESSAGE}"
    else
        GLOBAL_EXCEPTION="${GLOBAL_EXCEPTION} $1 DATABASE NOT EXIST."
        echo "${GLOBAL_EXCEPTION}"
    fi
}

drop_database "DirDB4"