drop () {
    commands=( $(echo "$1") )
    
    if [ ${commands[1]} == "TABLE" ] && [ ${commands[2]} ] && [ ! ${commands[3]} ] 
    then
        table_name=${commands[2]}
        table_meta=${commands[2]}"_meta"
        `rm $table_name`
        `rm $table_meta`
    else
        echo drop table syntax should be DROP TABLE table_name
    fi
    read_commands
}