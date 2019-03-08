. get_primary_data.sh
delete () {
    commands=( $(echo "$1") )
    if [ ${commands[1]} == "FROM" ]
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        
        if [ ! -f $table_name ]; then
            echo "table is not exist "
            read_commands
        fi
        #get the primary key data
        meta=`cat $table_meta`
        cols=(${meta//|/ })
        get_primary_data
        #check existance of primary key
        primary_key=${commands[3]}
        p_key_exists=0
        line_number=1
        for primary_field in "${primary_data[@]}"
        do
            if [ $primary_key == $primary_field ]
            then
                delete_line=""$line_number"d"
                `sed -i $delete_line wezza`
                echo data has been deleted
                read_commands
                break
            fi
            let "line_number+=1"
        done
        if [ $p_key_exists -eq 0 ]
        then
            echo primary key doesn\'t exist
            read_commands
        fi
        
        
        
        
        
        
        
        
    else
        echo delete syntax is DELETE FROM table_name primary_key
    fi
    
    
}