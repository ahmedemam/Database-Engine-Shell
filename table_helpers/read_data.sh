#!/usr/bin/env bash

function read_data () {
    let j=2
    for (( i=4; i<=${#commands[@]}-1; i++ ))
    do
        # cut the fields
        type=`cut -d "|" -f $j <<< ${meta}`
        let pr=$j-1
        _primary=`cut -d "|" -f ${pr} <<< ${meta}`
        if [[ ${type} =~ [a-zA-Z]+ ]] && [[ ${_primary} != "PRIMARY" ]]
        then
            # check the datatype
            if ([[ $type == "string" ]] && ( [[ ${commands[$i]} =~ [a-zA-Z]+ ]] || [[ ${commands[$i]} == "-" ]])) || ([[ ${type} == "int" ]] && ( [[ ${commands[$i]} =~ [0-9]+ ]] || [[ ${commands[$i]} == "-" ]]))
            then
                data+=( ${commands[$i]} )
            else
                printf '#> \e[41mINVALID DATATYPE\e[49m\n'
                read_commands
            fi
            let "j+=2"
        else
            printf '#> \e[41mTOO MANY ARGUMENTS.\e[49m\n'
            #that's because the value of j will be creater than the number of cols in
            read_commands
            break
        fi
        # the last element coan be read as empty string so we ignore
    done
    primary_key_data=${data[fieldNo-1]}
            if [[ ${primary_key_data} == "-" ]]
        then
            printf '#> \e[38;5;204mPrimary Key Cannot be null value\e[49m\n'
            read_commands
            break
        fi
    for primary_field in "${primary_data[@]}"
    do
        if [[ ${primary_key_data} == ${primary_field} ]]
        then
            printf '#> \e[38;5;204m${primary_key_data} exists in ${primary} column which is primary.\e[49m\n'
            read_commands
            break
        fi
    done
    #check number of arguments
    #cols ${#cols[@]}
    let colNo="(${#cols[@]}-2)/2"
    if [[ ${#data[@]} -lt ${colNo} ]]
    then
        printf '#> \e[41mTOO LITTLE ARGUMENTS.\e[49m\n'
        read_commands
    fi
}