#!/usr/bin/env bash

read -p $'Which files do you want to commit ?\n' FILES

echo $'You are sending the following files:'
echo $FILES
#Display each file on a newline
#Autocomplete
#Number of element we are sending

git add $FILES
git commit -m "$1"

read -p $'On which branch do you want to push ?\n' BRANCH
echo $'remote-branch: origin\nlocal-branch: '$BRANCH''
git push origin $BRANCH

echo $'The actual state of your repository:'
git ls-files