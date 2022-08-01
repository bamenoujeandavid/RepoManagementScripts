#!/bin/bash


if [ $# -ne 1 ]; then
    echo -e $'Invalid operation:\n\e[4mUsage\e[0m: ./TheDeliverer.sh <conventional_commit_message>'
    exit 0
fi

function currentStatusOfLocalRepository() {
    echo -e "\e[4m$(tput setaf 1)Untracked files:\e[0m"
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
    echo $''
    echo -e "$(tput bold)Status:"
    git status -s

    if [[ $ARGS -eq 1 ]]; then
        git commit -m "$COMMIT_MESSAGE"
        checkBranch
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
    exit 1
}

main