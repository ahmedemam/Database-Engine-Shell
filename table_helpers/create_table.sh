#!/usr/bin/env bash

function create_table () {
    commands=( $(echo "$1") )
    if [[ ${commands[1]} == "TABLE" ]] && [[ ${commands[2]} ]] && [[ ${commands[3]} ]] && [[ ${commands[4]} ]]; then
        table_name=${commands[2]}"_meta"
        if [[ -f ${table_name} ]]; then
            GLOBAL_EXCEPTION="#> \e[41m TABLE (NAME) ALREADY EXIST.\e[49m\n"
            printf "${GLOBAL_EXCEPTION}"
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
                        printf "#> \e[41m Please: Specify Valid Data Type.\e[49m\n"
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
        printf Please select primary key:
        select col in ${columns[@]}
        do
            printf "$col selected"
            printf -n "PRIMARY|$col" >> ${table_name}
            break
        done
        printf "#> \e[42mTABLE CREATED SUCCESSFULLY.\e[49m\n"
    else
            printf '#> \e[41mcreate syntax should be CREATE TABLE table_name col_name data_type.\e[49m\n'
    fi
        read_commands
}

