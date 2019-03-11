show_tables () {
    files=($(ls))
    n=0
    for table in "${files[@]}"
    do
        if [[ "${table: -5}" != "_meta" ]]
        then
            printf ".> \e[38;5;82m${table##*/}\e[49m\n"
            let "n+=1"
        fi
    done
    if [[ $n -eq 0 ]]
    then
            printf ".> \e[48;5;124mThere is no tables yet\e[49m\n"
    fi
    read_commands
}