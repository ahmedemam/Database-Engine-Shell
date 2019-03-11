#!/usr/bin/env bash

function create_table () {
    commands=( $(echo "$1") )
    if [[ ${commands[1]} == "TABLE" ]] && [[ ${commands[2]} ]] && [[ ${commands[3]} ]] && [[ ${commands[4]} ]]; then
        table_name=${commands[2]}"_meta"
        if [[ -f ${table_name} ]]; then
            GLOBAL_EXCEPTION="#> \e[38;5;196m TABLE (NAME) ALREADY EXIST.\e[49m\n"
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
                        printf "#> \e[38;5;196m Please: Specify Valid Data Type.\e[49m\n"
                        rm "$table_name"
                        rm ${commands[2]}
                        read_commands
                        break
                    fi
                fi
                if [[ $(($i % 2)) -ne "0" ]]
                then
                    if [[ "${commands[$i]}" == "PRIMARY" ]]
                    then
                        printf '#> \e[38;5;195m PRIMARY is a reserved word.\e[49m\n'
                        rm "$table_name"
                        rm ${commands[2]}
                        read_commands
                    fi
                    columns+=( ${commands[$i]} )
                fi
                echo -n "${commands[$i]}|" >> ${table_name}
            fi
        done
        
        for col in "${columns[@]}"
        do
            count=0
            current_col=$col
            for coll in "${columns[@]}"
            do
                if [[ "$coll" == "$current_col"  ]]
                then
                    let "count+=1"
                fi
            done
            if [[ $count -gt 1 ]]
            then
                printf '#> \e[38;5;196mCol name is dublicated : failed to create table.\e[49m\n'
                rm "$table_name"
                rm ${commands[2]}
                read_commands
            fi
        done
        printf "\e[38;5;220mPlease select primary key:\e[49m\n"
        select col in ${columns[@]}
        do
            printf "$col selected"
            echo -n "PRIMARY|$col" >> ${table_name}
            break
        done
        printf "#> \e[38;5;82m TABLE CREATED SUCCESSFULLY.\e[49m\n"
    else
        printf '#> \e[38;5;196m create syntax should be CREATE TABLE table_name col_name data_type.\e[49m\n'
    fi
    read_commands
}

