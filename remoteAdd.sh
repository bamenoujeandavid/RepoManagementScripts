#!/usr/bin/env bash

#-s means short (just try it)
echo $'Change log:'
git status -s
echo $''

read -p $'Which files do you want to commit ?\n' FILES
#Display each file on a newline
#Autocomplete

git add $FILES
git commit -m "$1"

read -p $'On which branch do you want to push ?\n' BRANCH
echo $'remote-branch: origin\nlocal-branch: '$BRANCH''
git push origin $BRANCH

echo $'The actual state of your repository:'
git ls-files