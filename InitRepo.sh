#!/bin/bash

if [ $# -ne 1 ]; then
    echo -e $'Invalid operation:\n\e[4mUsage\e[0m: ./ImportLib.sh <destination_folder>'
    exit 0
fi

#Import all your functions and default unit_testing functions
CURRENT_USER=$USER
LIB="/home/$CURRENT_USER/Epitech-lib"

cp $LIB $1 -r

#creer alias pour copier directement le InitRepo et le Deliverer
#alias script='mv ~/RepoManagementScript/InitRepo.sh ~/RepoManagementScript/TheDeliverer.sh ./'


#Creer makefile par defaut

#All Makefile variables:
#Makefile path
M_PATH=$1/Makefile

#Binary Name
NAME=$2

#Creer le fichier Makefile
touch Makefile
mv Makefile $1
echo $'Makefile created...'

#Header Epitech
echo $'##' >> $M_PATH
echo $'## EPITECH PROJECT, 2022' >> $M_PATH
echo $'## Makefile C' >> $M_PATH
echo $'## File description:' >> $M_PATH
echo $'## GNUmakefile' >> $M_PATH
echo $'##' >> $M_PATH

#SRC - OBJ - NAME - files

echo -ne $'\nSRC\t=\t$(shell find . -type f -name "*.c")\n\n' >> $M_PATH
echo -ne $'OBJ\t=\t$(SRC:.c=.o)\n\n' >> $M_PATH
echo -ne "NAME\t=\tproject_name\n\n" >> $M_PATH

#rule 'all'
echo -ne $'all:\t$(NAME)\n\n' >> $M_PATH

#valgrind compilation:
echo -ne $'%.o:\t%.c\n\tgcc -c $< -o $@ -g3\n\n' >> $M_PATH

echo -ne $'$(NAME):\t$(OBJ)\n\tgcc -o $(NAME) $(OBJ) -g3\n\n' >> $M_PATH

#clean rule:
echo -ne $'clean:\n\t-rm -f $(OBJ)\n\n' >> $M_PATH

#fclean rule:
echo -ne $'fclean:\tclean\n\t-rm -f $(NAME)\n\t-rm -f *~\n\t-rm -f *#\n\t-rm -f vgcore.*\n\n' >> $M_PATH

#re rule:
echo -ne $'re:\tfclean all\n\n' >> $M_PATH

#unit_test rule
#PHONY
echo -ne $'.PHONY:\tclean fclean all re\n\n' >> $M_PATH