#!/usr/bin/env bash
# Root Home Directory
ROOT_HOME_DIRECTORY="$HOME/Database_Engine_Shell_Source/"
# Database Directory
DATABASES_DIRECTORY="${ROOT_HOME_DIRECTORY}Databases"
# Users Database List File
USERS_FILES_PRIVILEGES="$ROOT_HOME_DIRECTORY/users_data"
# Global Error/Exception
GLOBAL_EXCEPTION='#> exception:'
GLOBAL_MESSAGE='#> '
# Database Use/In Now
DATABASE_CURSOR=''

. ./general_helper.sh

# create files and folders for 1st time application
function initial_application_install()
{
    # mkdir -p $DATABASES_DIR :set directory application & databsaes in once
    # instead of 2 commands
    ####### MAKE THEM HIDDEN #######
    printf '\t\t\t \e[100m##### Welcome to Database Engine Shell ##### \e[49m \n'
    printf '\t\t\t\t \e[102m##### START ENGINE ##### \e[49m\n'
    if [[ ! -d "$ROOT_HOME_DIRECTORY" ]]; then
        mkdir ${DATABASES_DIRECTORY} -p
        touch ${USERS_FILES_PRIVILEGES}
        cd "$ROOT_HOME_DIRECTORY"
        printf '#> \e[92m installation succeeded:)\e[49m\n'
    else
        cd "$ROOT_HOME_DIRECTORY"
    fi
}

#function for synatax errors
#if conditions for each word in the file
function start_application() {
    initial_application_install
    command="'     '"
        `: > ./currentCommand`
    read_commands
}

start_application


# username ahmed password 54654646