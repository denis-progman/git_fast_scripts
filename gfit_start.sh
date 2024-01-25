#!/bin/bash
source "$(dirname "$0")/functions.sh"

repo_url=
token=

while getopts ":r:k:" opt; do
  case $opt in
    r)  repo_url=$OPTARG
        ;;
    k)  token=$OPTARG
        ;;
    \?)
        p_error "Invalid option: -$OPTARG\n"
        exit 1
        ;;
    :)
        p_warning "Option -$OPTARG requires an argument.\n"
        exit 1
        ;;
  esac
done

check_git=$(find . -type d -name ".git")
current_path=$(pwd)

if [[ ! -z $check_git ]]; then
    p_warning "Attention! Found existed repositoriy in '$current_path'!"
    read -p "${bold}Are you sure you want to delete it and make new one?${reset} (yes): " check
    if [[ $check == "yes" ]]
    then
        rm -fr .git
    else
        p_bold "The operation's canceled!"
        exit 1
    fi
fi

if [[ $(trim $repo_url) == "" ]]; then
    p_error "You have to specify repository url as a first param or with the '-r' flag"
    exit 1
fi

git init

if [[ -z $(trim $token) ]]; then
    p_warning "warning! trying the ssh connection with default ssh key. You can specify the shh key for this repo with '-k' flag"
else 
    git config --add --local core.sshCommand "ssh -i $token"
fi

p_success "r = '$repo_url' t = '$token'"
exit 1

check_gitignore=$(find . -name ".gitignore")
if [[ -z $check_gitignore ]]; then
    printf ".vscode\n.idea\n.env\n.terraform\n.DS_Store\n" >> .gitignore
fi

check_read_me=$(find . -name ./README.md)
if [[ -z $check_read_me ]]; then
    touch README.md
fi

git add .
git commit -m "start"
git branch -M main
git remote add origin $repo_url
git push -u origin main
git checkout -b dev
git push --set-upstream origin dev
git status

p_success "Done!"
