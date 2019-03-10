#!/usr/bin/env bash
function select_one () {
    commands=( $(printf "$1") )
    if [[ ${commands[5]} ]] || [[ ! ${commands[2]} ]] || [[ ! ${commands[3]} ]] || [[ ! ${commands[4]} ]]
    then
        printf select one syntax should be SELECT ROW FROM table_name primary_key
                read_commands
        else
    if [[ ${commands[1]} == "ROW" ]] && [[ ${commands[2]} == "FROM" ]]
    then
        table_name=${commands[3]}
        table_meta=${commands[3]}"_meta"
        if [[ ! -f ${table_name} ]]; then
            printf "#> \e[41mTABLE NOT EXIST.\e[49m\n"
            read_commands
        fi
        #get the primary key data
        meta=`cat $table_meta`
        cols=(${meta//|/ })
        get_primary_data
        #check existence of primary key
        primary_key=${commands[4]}
        p_key_exists=0
        line_number=1
        for primary_field in "${primary_data[@]}"
        do
            if [[ ${primary_key} == ${primary_field} ]]
            then
                show_number=""$line_number"p"
                sed -n ${show_number} ${table_name}
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
        printf '#> \e[41mdelete syntax error: should be DELETE FROM table_name primary_key\e[49m\n'
        read_commands
    fi
    fi
}