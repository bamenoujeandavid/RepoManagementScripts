#!/bin/bash


if [ $# -ne 1 ]; then
    echo -e $'Invalid operation:\n\e[4mUsage\e[0m: ./TheDeliverer.sh <conventional_commit_message>'
    notify-send -t 3000 -i face-sad "ERROR" "Please, read the usage !"
    exit 0
fi

function currentStatusOfLocalRepository() {
    echo "$(tput bold)Untracked/Modified files:$(tput sgr0)"
    git status -s
    echo $''
}

function displayCurrentBranch() {
    echo -n "$(tput bold)Current branch: $(tput sgr0)"
    git status | head -n 1 | awk '{print $3}'
    echo $''
}

ARGS=$#
COMMIT_MESSAGE=$1

function checkBranch() {
    read -p $'Do you want to push on your current branch ? [Y/n] ' VALIDATION

    if [ "$VALIDATION" == "y" ] || [ "$VALIDATION" == "Y" ] || [ -z "$VALIDATION" ]; then
        git push origin `git status | head -n 1 | awk '{print $3}'`
        echo $''
    elif [ "$VALIDATION" == "n" ] || [ "$VALIDATION" == "N" ]; then
        read -p $'On which branch do you want to push ?\n' BRANCH
        echo -e $'\033[1mremote-branch: \033[0m'$BRANCH''
        git push origin $BRANCH
        echo $''
    else
        notify-send -t 3000 -i face-sad "ERROR" "Please, choose between 'y' and 'n'"
        exit 0
    fi
}

function commitFiles() {
    read -p $'Which files do you want to commit ?\n' FILES

    if [ -z $FILES ]; then
        "Nothing specified, nothing added."
        exit 0
    fi

    git add $FILES
    echo $''
    echo -e "$(tput bold)Status:"
    git status -s
    echo $''

    git commit -m "$COMMIT_MESSAGE"
    echo $''
    read -p $"$(tput bold)Do you confirm the commit message ? [Y/n] $(tput sgr0)" CONFIRMATION
    if [ "$CONFIRMATION" == "y" ] || [ "$CONFIRMATION" == "Y" ] || [ -z "$CONFIRMATION" ]; then
        checkBranch
    elif [ "$CONFIRMATION" == "n" ] || [ "$CONFIRMATION" == "N" ]; then
        read -p $'Please enter the new message: ' MESSAGE
        git commit --amend -m "$MESSAGE"
    else
        notify-send -t 3000 -i face-sad "ERROR" "Please, choose between 'y' and 'n'"
        exit 0
    fi
}

function remoteRepositoryStatus() {
    echo -e "\033[1mThe actual state of your repository:\033[0m"
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