#!/bin/bash

git add .
git commit -am "${1}"
git push

current_brench=$(git branch --show-current) 
git status
echo "Work with $current_brench is compliteted."

if [ ! -z $2 ] 
then
    git checkout $2
    git merge $current_brench
    git push

    git checkout $current_brench
    git status
    echo "Work with $2 is compliteted. You've swiched back to $current_brench"
fi
