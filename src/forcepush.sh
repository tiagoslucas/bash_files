#!/bin/bash
if ! command -v git &>/dev/null;
then
	printf "You have to install git to use forcepush!\n"
	exit 1
fi

git add -A
git commit -C HEAD --amend
git push --force-with-lease
git status
