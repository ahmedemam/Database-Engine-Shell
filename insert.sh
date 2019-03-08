get_primary_data () {
    cols=(${meta//|/ })
    for (( i=0; i<=${#cols[@]}-1; i++ ))
    do
        if [ ${cols[$i]} == "PRIMARY" ]
        then
            primary=${cols[$i+1]}
            break
        fi
    done
    #now get the field number we increment field by 5 and devide by 10
    fieldNo=10
    for field in "${cols[@]}"
    do
        if [ $field == $primary ]
        then
            let fieldNo=$fieldNo/10
            break
        fi
        ((fieldNo+=5))
    done
    `cut -d "|" -f $fieldNo $table_name > primary_data`
    primary_data=()
    for w in $(<./primary_data)
    do
        primary_data+=( $w )
    done
    `rm primary_data`
    
}

insert () {
    commands=( $(echo "$1") )
    if [ ${commands[1]} == "INTO" ]
    then
        #get the table file and the meta data
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        if [ ! -f $table_name ]; then
            echo "table is not exist "
            read_commands
        fi
        if [ ${commands[3]} == "VALUES" ]
        then
            data=()
            #data which will be inserted
            meta=`cat $table_meta`
            #get the field number
            #get the primary key
            get_primary_data
            # $fieldNo is the field number
            
            # loop through specific indecies of the array
            let j=2
            for (( i=4; i<=${#commands[@]}-1; i++ ))
            do
                # cut the fields
                type=`cut -d "|" -f $j <<< $meta`
                if [[ $type =~ [a-zA-Z]+ ]]
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
                    echo out of range
                    #that's because the value of j will be creater than the number of cols in
                    read_commands
                    break
                fi
                # the last element cocan be read as empty string so we ignore
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
            for field in "${data[@]}"
            do
                echo -n "$field|" >> $table_name
            done
            echo -e >> $table_name
            read_commands
        else
            echo Syntax error, table name must be followed by VALUE
        fi
    else
        echo Syntax error, the second argument should be INTO
    fi
}