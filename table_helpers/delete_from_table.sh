#!/usr/bin/env bash

function delete_from_table () {
    commands=( $(printf "$1") )
    if [[ ${commands[4]} ]] || [[ ! ${commands[2]} ]] || [[ ! ${commands[3]} ]]
    then
        printf delete syntax should be DELETE FROM table_name primary_key
                read_commands
        else
    if [[ ${commands[1]} == "FROM" ]]
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        if [[ ! -f ${table_name} ]]; then
            printf "#> \e[38;5;196mTABLE NOT EXIST.\e[49m\n"
            read_commands
        fi
        #get the primary key data
        meta=`cat $table_meta`
        cols=(${meta//|/ })
        get_primary_data
        #check existence of primary key
        primary_key=${commands[3]}
        p_key_exists=0
        line_number=1
        for primary_field in "${primary_data[@]}"
        do
            if [[ ${primary_key} == ${primary_field} ]]
            then
                delete_line=""$line_number"d"
                `sed -i ${delete_line} ${table_name}`
                printf data has been deleted
                read_commands
                break
            fi
            let "line_number+=1"
        done
        if [[ ${p_key_exists} -eq 0 ]]
        then
            printf primary key doesn\'t exist
            read_commands
        fi
    else
        printf '#> \e[38;5;196mdelete syntax error: should be DELETE FROM table_name primary_key\e[49m\n'
        read_commands
    fi
    fi
}