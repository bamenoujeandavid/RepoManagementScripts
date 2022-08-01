#!/bin/bash

function currentStatusOfLocalRepository() {
    echo -e "\e[4m$(tput setaf 1)Change log:\e[0m"
    git status -s
    echo $''
}

function displayCurrentBranch() {
    echo -ne "\e[4m$(tput setaf 1)Current branch:\e[0m "
    git status | head -n 1 | awk '{print $3}'
    echo $''
}

ARGS=$#
COMMIT_MESSAGE=$1

function checkBranch() {
    read -p $'Do you want to push on your current branch ? [Y/n] ' VALIDATION
    if [ "$VALIDATION" == "y" ] || [ "$VALIDATION" == "Y" ] || [ -z "$VALIDATION" ]; then
        git push origin `git status | head -n 1 | awk '{print $3}'`
        echo $'remote-branch: origin'
        echo $"local-branch: $(git status | head -n 1 | awk '{print $3}')"
        echo $''
    else 
        read -p $'On which branch do you want to push ?\n' BRANCH
        echo $'remote-branch: origin\nlocal-branch: '$BRANCH''
        git push origin $BRANCH
    fi
}

function commitFiles() {
    read -p $'Which files do you want to commit ?\n' FILES
    git add $FILES
    if [[ $ARGS -eq 1 ]]; then
        git commit -m "$COMMIT_MESSAGE"
        checkBranch
    elif [[ $ARGS -eq 0 ]]; then
        read -p $'Enter the commit message\n' C_MESSAGE
        read -p $'Co-authored by: ' CO_AUTHOR
        git commit -m "$C_MESSAGE$(echo "")$(echo "")Co-authored-by: $CO_AUTHOR"
    else
        echo $'Invalid operation'
    fi
}

function remoteRepositoryStatus() {
    echo -e "\e[4m$(tput setaf 1)The actual state of your repository:\e[0m"
    git ls-files
}

function main() {
    currentStatusOfLocalRepository
    displayCurrentBranch
    commitFiles
    remoteRepositoryStatus
}

main