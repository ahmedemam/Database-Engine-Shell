#!/usr/bin/bash
. create.sh
. insert.sh
. delete.sh
read_commands () {
    # clear the file if the program open
    `: > ./currentCommand`
    while true
    do
        #check if the file is empty to change the prompt corresponding to its state
        if [ ! -s ./currentCommand ]
        then
            read -p $'\e[0;1;35mm&aDB\e[0;1;36m >> ' command
        else
            read -p $'\e[0;1;36m.... ' command
        fi
        #check if he has pressed enter
        if [[ -z $command ]]
        then
            command="'     '"
            continue
        else
            #append the command to the file
            echo "$command" >> ./currentCommand
            if [ ${command: -1} = ";" ]
            then
                #remove the ; from the commands file
                truncate -s-2 ./currentCommand
                break
            fi
        fi
        if [ ${#command} -gt 3 ] && [ ${command: -4} = "exit" ]
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
    echo
    # clear the document for the next set of
    
    `: > ./currentCommand`
    if [ ${commands[0]} == "CREATE" ]
    then
        create "$(echo ${commands[@]})"
    elif [ ${commands[0]} == "INSERT" ]
    then
        insert "$(echo ${commands[@]})"
    elif [ ${commands[0]} == "DELETE" ]
    then
        delete "$(echo ${commands[@]})"
    else
        echo synatax error
        read_commands
    fi
    
}