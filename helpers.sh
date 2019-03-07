#!/usr/bin/bash
. ./change_prompt.sh
read_commands () {
    while true
    do
        read -p $'\e[0;1;35mm&aDB\e[0;1;36m >> ' command
        echo `expr length $command`
        if [[ -z $command ]]
        then
            command="'     '"
            continue
        else
            echo "$command" >> ./currentCommand
        fi
        if [ ${command: -1} = ";" ] 
        then
        break 
        elif [ `expr length $command` -gt 3 ] && [ ${command: -4} = "exit" ] 
        then
            exec bash
        else
        continue
        fi
        #function to read the commands and start using cases
    done
    echo done
    commands=()
    for w in $(<./currentCommand)
    do
        commands+=$w
    done
    `cat > ./currentCommand`
    for i in "${commands[@]}"
do
	echo "$i \r"
done

}