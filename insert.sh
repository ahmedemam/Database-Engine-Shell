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
            meta=`cat $table_meta`
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
                    read_commands
                    break
                fi
                # the last element cocan be read as empty string so we ignore
            done
            
            for var in "${data[@]}"
            do
                echo -n "$var|" >> $table_name
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