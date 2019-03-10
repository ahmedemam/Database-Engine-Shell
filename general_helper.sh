#!/usr/bin/env bash

. ./table_helpers/create_table.sh
. ./table_helpers/delete_from_table.sh
. ./table_helpers/drop_table.sh
. ./table_helpers/get_primary_data.sh
. ./table_helpers/insert_into_table.sh
. ./table_helpers/read_data.sh
. ./table_helpers/update_table.sh
. ./database_helpers/create_database.sh
. ./database_helpers/use_database.sh
. ./database_helpers/drop_database.sh
. ./database_helpers/show_databases.sh


function read_commands () {
    # clear the file if the program open
    `: > ./currentCommand`
    while true
    do
        #check if the file is empty to change the prompt corresponding to its state
        if [[ ! -s ./currentCommand ]]
        then
            read -p $'##_Shell> ' command
        else
            read -p $'....' command
        fi
        #check if he has pressed enter
        if [[ -z ${command} ]]
        then
            command="'     '"
            continue
        else
            #append the command to the file
            printf "$command" >> ./currentCommand
            if [[ ${command: -1} = ";" ]]
            then
                #remove the ; from the commands file
                truncate -s-2 ./currentCommand
                break
            fi
        fi
        if [[ ${#command} -gt 3 ]] && [[ "${command: -4}" = "exit" ]]
        then
            exec bash
        else
            continue
        fi
        #function to read the commands and start using cases
    done

    commands=()
    for w in $(<./currentCommand)
    do
        commands+=( $w )
    done
    # clear the document for the next set of

    `: > ./currentCommand`
   if [[ ${commands[0]} == "CREATE" ]] && [[ ${commands[1]} == "TABLE" ]]
    then
        create_table "$(printf ${commands[@]})"
    elif [[ ${commands[0]} == "INSERT" ]]
    then
        insert_into_table "$(printf ${commands[@]})"
    elif [[ ${commands[0]} == "DELETE" ]]
    then
        delete_from_table "$(printf ${commands[@]})"
    elif [[ ${commands[0]} == "UPDATE" ]]
    then
        update_table "$(printf ${commands[@]})"
    elif [[ ${commands[0]} == "DROP" ]]
    then
        drop_table "$(printf ${commands[@]})"

    elif [[ ${commands[0]}  == "CREATE" ]] && [[ ${commands[1]} == "DATABASE" ]] && [[ ${#commands[@]} -eq 3 ]]
    then
        create_database "$(printf ${commands[2]})"
    elif [[ ${commands[0]}  == "USE" ]] && [[ ${commands[1]} == "DATABASE" ]] && [[ ${#commands[@]} -eq 3 ]]
    then
        use_database "$(printf ${commands[2]})"
    elif [[ ${commands[0]}  == "DROP" ]] && [[ ${commands[1]} == "DATABASE" ]] && [[ ${#commands[@]} -eq 3 ]]
    then
        drop_database "$(printf ${commands[2]})"
    elif [[ ${commands[0]}  == "SHOW" ]] && [[ ${commands[1]} == "DATABASES" ]] && [[ ${#commands[@]} -eq 2 ]]
    then
        show_databases
    else
        printf "#> \e[41mSYNTAX ERROR:  input is unkown command.\e[49m\n"
        read_commands
    fi
}