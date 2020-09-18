#!/bin/sh
dependencies="git"
for dependency in $dependencies;
do
	if [ -z $(command -v $dependency) ];
	then
		printf "You have to install $dependency to use forcepush!\n"
		exit 1
	fi
done

if ! git rev-parse 2>/dev/null;
then
	printf "Please run forcepush on a git repository!\n"
	exit 1
fi

git add -A
git commit -C HEAD --amend
git push --force-with-lease
git status
