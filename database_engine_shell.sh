#!/usr/bin/bash
. helpers.sh
ROOT_HOME_DIR="$HOME/Database_Engine_Shell_Source"
DATABSES_DIR="$ROOT_HOME_DIR/Databases"
USERS_FILES_PRIVILLAGES="$ROOT_HOME_DIR/users_data"
# create files and folders for 1st time application
initial_application_install()
{
    # mkdir -p $DATABASES_DIR :set directory application & databsaes in once
    # instead of 2 commands
    clear
    echo $'\e[0;1;32mWelcome to \e[0;1;36mm&aDB :) '
        echo $'\e[0;1;31m==Please write========='

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

start_app() {
    initial_application_install
    command="'     '"
        `: > ./currentCommand`
    read_commands
    # ratebook
}

start_app
