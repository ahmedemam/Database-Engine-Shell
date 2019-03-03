#!bin/bash

ROOT_HOME_DIR="$HOME/Database_Engine_Shell_Source/"
DATABSES_DIR="$ROOT_HOME_DIR/Databases"
USERS_FILES_PRIVILLAGES="$ROOT_HOME_DIR/users_data"

# create files and folders for 1st time application
initial_application_install()
{
    # mkdir -p $DATABASES_DIR :set directory application & databsaes in once
    # instead of 2 commands
    mkdir $ROOT_HOME_DIR
    mkdir $DATABSES_DIR
    touch $USERS_FILES_PRIVILLAGES
    cd "$ROOT_HOME_DIR"
    echo '> SUCCESS: initial_application_install()'
}

initial_application_install