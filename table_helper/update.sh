. read_data.sh
update () {
    commands=( $(echo "$1") )
    if [ ${commands[1]} == "TABLE" ]
    then 
        #check existance of table        primary_key=${commands[3]}
        if [ ${commands[2]} ] && [ ${commands[3]} ] && [ ${commands[4]} ]
        #check existance of argument
        then
            table_name=${commands[2]}
            table_meta=${commands[2]}"_meta"
            if [ ! -f $table_name ]; then
                echo "table is not exist "
                read_commands
            fi
            #check primary key and get line the array name is primary_data
            meta=`cat $table_meta`
            cols=(${meta//|/ })
            get_primary_data
            primary_key=${commands[3]}
            #get line number
            p_key_exists=0
            line_number=1
            echo ${#primary_data[@]}
            for primary_field in "${primary_data[@]}"
            do
                if [ $primary_key == $primary_field ]
                then
                    p_key_exists=1
                    break
                fi
                let "line_number+=1"
            done
            #check if primary key exists
            if [ $p_key_exists -eq 0 ]
            then
                echo primary key doesn\'t exist
                read_commands
            fi
            #get data
            read_data #it will return $data as an array
            updated_row=""
            for field in "${data[@]}"
            do
                updated_row="${updated_row}${field}|"
            done
            sed_argument=""$line_number"s/.*/"$updated_row"/"
                        # sed -i '3s/.*/7|8|9/' wezza
            `sed -i $sed_argument $table_name`
        else
            echo update syntax should be UPDATE TABLE table_name primary_key data_by_order
        fi
    else
        echo update syntax should be UPDATE TABLE table_name primary_key data_by_order
    fi
            read_commands
}