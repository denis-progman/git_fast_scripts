#!/bin/bash
source "$(dirname "$0")/functions.sh"

check_git=$(find . -type d -name ".git")
current_path=$(pwd)

if [[ -z $check_git ]]; then
    p_error "Git repositoriy is not found in '$current_path'!"
    p_notice "You can create new one with 'git_start' script"
    exit 1
fi

current_brench=$(git branch --show-current) 

p_bold "${blue}Start Git ASP in '$current_path'"

git add .
git commit -am "${1}"
git push

git status
p_bold "Work with ${blue}$current_brench${reset}${bold} is compliteted."

if [[ ! -z $2 ]]; then
    git checkout $2
    git merge $current_brench
    git push

    git checkout $current_brench
    git status
    p_bold "Work with ${blue}$2${reset}${bold} is compliteted. You've swiched back to ${reset}${blue}$current_brench"
fi

p_success "All done - well done!"
