#!/bin/bash

if [ $# -ne 1 ]; then
    echo -e $'Invalid operation:\n\e[4mUsage\e[0m: ./ImportLib.sh <destination_folder>'
    exit 0
fi

#Import all your functions
CURRENT_USER=$USER
LIB="/home/$CURRENT_USER/Epitech-lib"

cp $LIB $1 -r

#Creer makefile par defaut