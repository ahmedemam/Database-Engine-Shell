#!/usr/bin/env bash

function create_table () {
    commands=( $(echo "$1") )
    if [[ ${commands[1]} == "TABLE" ]] && [[ ${commands[2]} ]] && [[ ${commands[3]} ]] && [[ ${commands[4]} ]]; then
        table_name=${commands[2]}"_meta"
        if [[ -f ${table_name} ]]; then
            GLOBAL_EXCEPTION="${GLOBAL_EXCEPTION} TABLE (NAME) ALREADY EXIST."
            echo "${GLOBAL_EXCEPTION}"
            read_commands
        fi
        columns=()
        touch "$table_name"
        touch ${commands[2]}
        for (( i=3; i<=${#commands[@]}; i++ ))
        do
            if [[ ${commands[$i]} != "" ]]
            then
                if [[ $(($i % 2)) -eq "0" ]]
                then
                    if [[ ${commands[$i]} != "int" ]] && [[ ${commands[$i]} != "string" ]]
                    then
                        echo "#> Please: Specify Valid Data Type."
                        rm "$table_name"
                        rm ${commands[2]}
                        read_commands
                        break
                    fi
                fi
                if [[ $(($i % 2)) -ne "0" ]]
                then
                    columns+=( ${commands[$i]} )
                fi
                echo -n "${commands[$i]}|" >> ${table_name}
            fi
        done
        echo Please select primary key:
        select col in ${columns[@]}
        do
            echo "$col selected"
            echo -n "PRIMARY|$col" >> $table_name
            break
        done
        echo "#> TABLE CREATED SUCCESSFULLY."
    else
        echo '#> create syntax should be CREATE TABLE table_name col_name data_type.'
    fi
        read_commands
}

