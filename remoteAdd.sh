#!/usr/bin/env bash

#-s means short (just try it)
echo $'Change log:'
git status -s
echo $''

echo -n "On branch: "
BR_NAME= git status | head -n 1 | awk '{print $3}'
echo $''

read -p $'Which files do you want to commit ?\n' FILES
#Autocomplete

git add $FILES
git commit -m "$1"

read -p $'Do you want to push on your current branch ? [Y/n]' VALIDATION

if [ "$VALIDATION" == "y" ] || [ "$VALIDATION" == "Y" ] || [ -z "$VALIDATION" ]; then
    echo $BR_NAME
    #git push origin $BR_NAME
    echo $'remote-branch: origin\nlocal-branch: '$BR_NAME''
else 
    read -p $'On which branch do you want to push ?\n' BRANCH
    echo $'remote-branch: origin\nlocal-branch: '$BRANCH''
    git push origin $BRANCH
fi

echo $'The actual state of your repository:'
git ls-files