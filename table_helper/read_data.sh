read_data () {
    let j=2
    for (( i=4; i<=${#commands[@]}-1; i++ ))
    do
        # cut the fields
        type=`cut -d "|" -f $j <<< $meta`
        let pr=$j-1
        _primary=`cut -d "|" -f $pr <<< $meta`
        if [[ $type =~ [a-zA-Z]+ ]] && [ $_primary != "PRIMARY" ]
        then
            # check the datatype
            if ([ $type == "string" ] && [[ ${commands[$i]} =~ [a-zA-Z]+ ]]) || ([ $type == "int" ] && [[ ${commands[$i]} =~ [0-9]+ ]])
            then
                data+=( ${commands[$i]} )
            else
                echo invalid data type
                read_commands
            fi
            let "j+=2"
        else
            echo too many arguments
            #that's because the value of j will be creater than the number of cols in
            read_commands
            break
        fi
        # the last element coan be read as empty string so we ignore
    done
    primary_key_data=${data[fieldNo-1]}
    for primary_field in "${primary_data[@]}"
    do
        if [ $primary_key_data == $primary_field ]
        then
            echo $primary_key_data exists in $primary coulmn which is primary
            read_commands
            break
        fi
    done
    #check number of arguments
    #cols ${#cols[@]}
    let colNo="(${#cols[@]}-2)/2"
    if [ ${#data[@]} -lt $colNo ]
    then
        echo small number of arguments
        read_commands
    fi
}