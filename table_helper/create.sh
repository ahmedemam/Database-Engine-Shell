create () {
    commands=( $(echo "$1") )
    if [ ${commands[1]} == "TABLE" ]
    then
        table_name=${commands[2]}"_meta"
        if [ -f $table_name ]; then
            echo "There is a table with the same name "
            read_commands
        fi
        #cols to be shown for sellection of primary key
        cols=()
        touch ${commands[2]}
        touch "$table_name"
        # loop through specific indecies of the array
        for (( i=3; i<=${#commands[@]}; i++ ))
        do
            # the last element can be read as empty string so we ignore
            if [[ ${commands[$i]} != "" ]]
            then
                if [ $(($i % 2)) -eq "0" ]
                then
                    #check the data type of the coulmns
                    if [[ ${commands[$i]} != "int" ]] && [[ ${commands[$i]} != "string" ]]
                    then
                        echo please specify valid data type
                        read_commands
                        break
                    fi
                fi
                if [ $(($i % 2)) -ne "0" ]
                #add them to the columns to select the primary key later
                then
                    cols+=( ${commands[$i]} )
                fi
                echo -n "${commands[$i]}|" >> $table_name
            fi
        done
        echo Please select primary key:
        select col in ${cols[@]}
        do
            echo "$col selected"
            echo -n "PRIMARY|$col" >> $table_name
            break
        done
        echo table has been create
        read_commands
    fi
}