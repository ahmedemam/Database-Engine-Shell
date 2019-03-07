#!bin/bash
start_bash_prompt () {
export PS2="\[\e[0;1;36m\] >> \[\e[0m\]"
}
end_bash_prompt () {
exec bash 
}

