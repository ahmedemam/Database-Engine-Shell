#!bin/bash
start_bash_prompt () {
export PS1="\[\e[0;1;35m\]m&aDB\[\e[0;1;36m\] >> \[\e[0m\]"
export PS2="\[\e[0;1;36m\] >> \[\e[0m\]"

}
end_bash_prompt () {
exec bash 
}

