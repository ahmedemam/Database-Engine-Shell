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
            printf "#> \e[48;5;124mTABLE NOT EXIST.\e[49m\n"
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
        printf "#> \e[30;48;5;28m DATA HAS BEEN DELETED.\e[49m\n"
                read_commands
                break
            fi
            let "line_number+=1"
        done
        if [[ ${p_key_exists} -eq 0 ]]
        then
            printf '#> \e[48;5;124mprimary key doesnot exist\e[49m\n'
            read_commands
        fi
    else
        printf '#> \e[48;5;124mdelete syntax error: should be DELETE FROM table_name primary_key\e[49m\n'
        read_commands
    fi
    fi
}