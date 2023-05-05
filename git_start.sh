#!/bin/bash

repo_url=""
token=""

while getopts ":r:t:" opt; do
  case $opt in
    r)  repo_url=$OPTARG
        ;;
    t)  token=$OPTARG
        ;;
    \?)
        echo "Invalid option: -$OPTARG\n"
        exit 1
        ;;
    :)
        echo "Option -$OPTARG requires an argument.\n"
        exit 1
        ;;
  esac
done

check_git=$(find . -type d -name ".git")
current_path=$(pwd)

if [ ! -z $check_git ]
then
    echo "Attention! Found existed repositoriy in '$current_path'!"
    read -p "Are you sure you want to delete it and make new one?(yes): " check
    if [ $check == "yes" ] 
    then
        rm -fr .git
    else
        echo "The operation's canceled!"
        exit 1
    fi
fi

if [ $repo_url == "" ] 
then
    echo "error! You have to specify repository url as a first param or with the '-r' flag"
    exit 1
fi

git init

if [ $token == "" ] 
then
    echo "warning! trying the ssh connection with default ssh key.\n You can specify the shh key for this repo with '-t' flag"
else 
    git config --add --local core.sshCommand "ssh -i $token"
fi

check_gitignore=$(find . -name ".gitignore")
if [ -z $check_gitignore ]
then
    printf ".vscode\n.idea\n.env\n.terraform\n.DS_Store\n" >> .gitignore
fi

check_read_me=$(find . -name ./README.md)
if [ -z $check_read_me ]
then
    touch README.md
fi

git add .
git commit -m "start"
git branch -M main
git remote add origin git@github.com:$repo_url
git push -u origin main
git checkout -b dev
git push --set-upstream origin dev
git status
