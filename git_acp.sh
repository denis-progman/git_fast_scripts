#!/bin/bash

git add .
git commit -am "${1}"
git push

current_brench = $(git branch --show-current) 
if [ ! -z $2 ] 
then
    git checkout $2
    git merge $current_brench
    git push
    git checkout current_brench
fi