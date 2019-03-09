#!/usr/bin/bash
. ./change_prompt.sh
. ./helpers.sh

ROOT_HOME_DIR="$HOME/Database_Engine_Shell_Source/"
DATABSES_DIR="$ROOT_HOME_DIR/Databases"
USERS_FILES_PRIVILLAGES="$ROOT_HOME_DIR/users_data"
# create files and folders for 1st time application
initial_application_install()
{
    # mkdir -p $DATABASES_DIR :set directory application & databsaes in once
    # instead of 2 commands
    ####### MAKE THEM HIDDEN #######
    start_bash_prompt
    if [ ! -d "$ROOT_HOME_DIR" ]; then
        mkdir $DATABSES_DIR -p
        touch $USERS_FILES_PRIVILLAGES
        cd "$ROOT_HOME_DIR"
        echo '> installation succedded :) '
    else
        cd "$ROOT_HOME_DIR"
    fi
}
#function for synatax errors
#if conditions for each word in the file

start_application() {
    initial_application_install
    command="'$*'"
    while [ ${command: -1} != ";" ]
    do
        read -p $'\e[0;1;36m>> ' command
        echo $command >> ./currentCommand
        #function to read the commands and start using cases
    done
    read_commands
}

start_app
