#!/usr/bin/env bash

function clear_screen(){
    #crontab -e
    clear
    @reboot sh "./${CURRENT_RUNNER}"
    sleep 1
}



#    echo -en "$Green ✔ $Color_Off "
#    echo -en "$Red ✘ $Color_Off "
