#!/usr/bin/env bash

function get_primary_data () {
    data=()
    for (( i=0; i<=${#cols[@]}-1; i++ ))
    do
        if [[ ${cols[$i]} == "PRIMARY" ]]
        then
            primary=${cols[$i+1]}
            break
        fi
    done
    #now get the field number we increment field by 5 and devide by 10
    fieldNo=10
    for field in "${cols[@]}"
    do
        if [[ ${field} == ${primary} ]]
        then
            let fieldNo=$fieldNo/10
            break
        fi
        ((fieldNo+=5))
    done
    `cut -d "|" -f ${fieldNo} ${table_name} > primary_data`
    primary_data=()
    for w in $(<./primary_data)
    do
        primary_data+=( ${w} )
    done
    `rm primary_data`
}