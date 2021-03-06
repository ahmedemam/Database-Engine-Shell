#!/usr/bin/env bash

function insert_into_table () {
    commands=( $(printf "$1") )
    if [[ ${commands[1]} == "INTO" ]]
    then
        #get the table file and the meta data
        if [[ ${commands[2]} ]]
        #check existence of argument
        then
            table_name=${commands[2]}
            table_meta=${commands[2]}"_meta"
            if [[ ! -f ${table_name} ]]; then
                printf "#> \e[48;5;124mTABLE NOT EXIST.\e[49m\n"
                read_commands
            fi
            if [[ ${commands[3]} == "VALUES" ]] && [[ ${commands[4]} ]]
            #checkc existence of argument
            then
                #data which will be inserted
                meta=`cat ${table_meta}`
                cols=(${meta//|/ })
                get_primary_data
                # loop through specific indexes of the array which is the inserted data
                read_data
                #write the data
                for field in "${data[@]}"
                do
                    echo -n "$field|" >> ${table_name}
                done
                echo -e >> ${table_name}
                printf "#> \e[30;48;5;28m DATA HAS BEEN INSERTED.\e[49m\n"
                
            else
                printf '#> \e[48;5;124mInsert syntax error: should be INSERT INTO table_name VALUES data_by_order.\e[49m\n'
            fi
        else
            printf '#> \e[48;5;124mInsert syntax error: should be INSERT INTO table_name VALUES data_by_order.\e[49m\n'
        fi
    else
        printf '#> \e[48;5;124m”Insert syntax should be INSERT INTO table_name VALUES data_by_order.\e[49m\n'
    fi
    read_commands
}