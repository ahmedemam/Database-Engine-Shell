# to loop through array
for i in "${array[@]}"
do
	echo $i
done
#array length

${#distro[@]}

#last element in string 
"${str: -1}"

#read from file and put into array 
    commands=()
    for w in $(<./currentCommand)
    do
        commands+=( $w )
    done