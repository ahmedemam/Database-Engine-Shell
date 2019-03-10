#!/usr/bin/env bash
# Root Home Directory
ROOT_HOME_DIRECTORY="$HOME/Database_Engine_Shell_Source/"
# Database Directory
DATABASES_DIRECTORY="${ROOT_HOME_DIRECTORY}Databases"
# Users Database List File
USERS_FILES_PRIVILEGES="$ROOT_HOME_DIRECTORY/users_data"
#Current Command File
CURRENT_COMMAND="$ROOT_HOME_DIRECTORY/currentCommand"

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
    echo $'\e[0;1;32mWelcome to \e[0;1;36mm&aDB :) '
    echo $'\e[0;1;31m====You can start writing commands======='
    if [[ ! -d "$ROOT_HOME_DIRECTORY" ]]; then
        mkdir ${DATABASES_DIRECTORY} -p
        touch ${USERS_FILES_PRIVILEGES}
        cd "$ROOT_HOME_DIRECTORY"
        echo '#> installation succedded :) '
    else
        cd "$ROOT_HOME_DIRECTORY"
    fi
}
#function for synatax errors
#if conditions for each word in the file

function start_application() {
    initial_application_install
    command="'     '"
    `: > $CURRENT_COMMAND`
    read_commands
}
start_application
