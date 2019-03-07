insert () {
    commands=( $(echo "$1") )
    if [ ${commands[1]} == "INTO" ]
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        if [ ! -f $table_name ]; then
            echo "table is not exist "
            read_commands
        fi
        if [ ${commands[3]} == "VALUES" ]
        then
        echo $table_meta
            meta=`cat $table_meta`
            echo $meta

            # loop through specific indecies of the array
            for (( i=4; i<=${#commands[@]}; i++ ))
            do

                # the last element can be read as empty string so we ignore
                if [[ ${commands[$i]} != "" ]]
                then
               if [ $(($i % 2)) -eq "0" ]
                    then
                        #check the data type of the coulmns
                        if [[ ${commands[$i]} != "int" ]] && [[ ${commands[$i]} != "string" ]]
                        then
                            echo please specify valid data
                            read_commands
                            break
                        fi
                    fi
                    echo -n "${commands[$i]}|" >> $table_name
                fi
            done
        else
            echo Syntax error, table name must be followed by VALUE

        fi
    else
        echo Syntax error, the second argument should be INTO
    fi
}