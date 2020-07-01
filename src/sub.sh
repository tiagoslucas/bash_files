#!/bin/bash
origin=$(pwd)
if [[ `echo $1 | grep [[:alpha:]]` && -z `git $1 2>&1 | grep "not a git command"` ]]
then
  gitcmd="git $1"
  type='cmd'
else
  gitcmd='git fetch && git status -s && git --no-optional-locks status | grep -e behind -e ahead -e each'
  type='dir'
fi

if [[ $# -gt 1 && $type = 'cmd' ]]
then
  sources="${@:2}"
elif [[ $# -gt 0 && $type = 'dir' ]]
then
  sources="${@}"
else
  sources=( . )
fi

repos=""
for source in ${sources[@]}
do
  if [[ -d $origin/$source ]]
  then
    for repo in `ls -a $origin/$source`
    do
      if [[ -d $origin/$source/$repo && -d $origin/$source/$repo/.git ]]
      then
        repos="$repos $origin/$source/$repo"
      fi
    done
  elif [[ -z `eval "git $source" 2>&1 | grep -e "not a git command" -e "unknown option"` ]]
  then
    gitcmd="$gitcmd && git $source"
  elif [[ -z `eval "$gitcmd $source" 2>&1 | grep -e "not a git command" -e "unknown option"` ]]
  then
    gitcmd="$gitcmd $source"
  fi
done

for i in ${repos[@]}
do
	cd $i
    repo=$(git config --get remote.origin.url)
    printf "%s\n" "${repo##*/}"
    eval "$gitcmd"
    printf "\n"
    cd $origin
done
