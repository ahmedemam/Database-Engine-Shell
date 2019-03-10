#!/usr/bin/env bash

# select row - primary key

# TABLE_NAME PRIMARY_NAME PRIMARY_VALUE
function select_row(){
    if [[ $# -eq 2 ]]; then
    TABLE_NAME=$1
    PRIMARY_VALUE=$2
    # ------------------------------
    TABLE_META="${TABLE_NAME}_meta"
    META_DATA="cat $TABLE_META"
    PRIMARY_POSITION=''
    PRIMARY_NAME=''
        # get primary name and position
        set -- "$META_DATA"
        IFS="|"; declare -a Array=($*)
        for (( i=0; i<${#Array[@]}; i++ ))
        do
            if [[ $Array[i] == 'PRIMARY' ]]; then
                PRIMARY_NAME="${Array[i+1]}"
            fi
        done
        # get primary position
        for (( i=0; i<${#Array[@]}-2; i++ ))
        do
            if [[ "${Array[i]}" == "${PRIMARY_NAME}" ]]; then
                PRIMARY_POSITION="$i"
            fi
        done
        # select data based on primary
        while read -r line; do
           set -- "${line}"
           IFS="|"; declare -a Array=($*)
           if [[ ${Array[PRIMARY_POSITION]}  == ${PRIMARY_VALUE} ]]; then
               for (( i=0; i<${#Array[@]}; i++ ))
               do
                    printf "\t ${Array[i]}"
               done
               printf "\n"
               break
           fi
        done < "${TABLE_NAME}"
    else
        printf "#> SYNTAX ERROR."
    fi
    read_commands
}