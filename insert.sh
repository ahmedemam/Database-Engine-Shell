. get_primary_data.sh
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
            cols=(${meta//|/ })
            get_primary_data
            # loop through specific indecies of the array which is the inserted data
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
            echo insert syntax is INSERT INTO table_name VALUES data_by_order
        fi
    else
        echo insert syntax is INSERT INTO table_name VALUES data_by_order
    fi
}