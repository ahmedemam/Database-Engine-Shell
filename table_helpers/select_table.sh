#!/usr/bin/env bash
# select all from tableName: 4 parameters
# select row from tableName primary value: 6 paramters
function select_all_from_table() {
    if [[ $1 ]]; then
        TABLE_META="$1_meta"
        TABLE_NAME="$1"
        # Metadata Printing
        META_DATA=`cat ${TABLE_META}`
        set -- "$META_DATA"
        IFS="|"; declare -a Array=($*)
        printf "#> TABLE: $TABLE_NAME:\n"
        for (( i=0; i<${#Array[@]}-2; i++ ))
        do
            if [[ "${Array[i]}" != "int" ]] && [[ "${Array[i]}" != "string" ]] && [[ "${Array[i]}" != "PRIMARY" ]];
            then
                printf "\t\t ${Array[i]}"
            fi
        done
        printf "\n"
        # Table Content Printing
        while read -r line; do
            set -- "${line}"
            IFS="|"; declare -a Array=($*)
            for (( i=0; i<${#Array[@]}; i++ ))
            do
                printf "\e[38;5;255m\t\t ${Array[i]}"
            done
            printf "\n\e[0;1;93m"
        done < "${TABLE_NAME}"
    else
        printf "#>\e[48;5;124m SYNTAX ERROR.\e[49m\n"
    fi
    unset IFS
            read_commands
}
