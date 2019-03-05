#!/usr/bin/bash
read_commands () {
    commands=()
    for w in $(<./currentCommand)
    do
        commands+=$w
    done
}