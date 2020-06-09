#!/bin/bash
origin=$(pwd)
if [[ `echo $1 | grep [[:alpha:]]` && -z `git $1 2>&1 | grep "not a git command"` ]]
then
  gitcmd=$1
  var1='cmd'
else
  gitcmd='fetch && git status -s && git status | grep -e behind -e ahead -e each'
  var1='dir'
fi
if [[ $# -gt 1 && $var1 = 'cmd' ]]
then
  sources="${@:2}"
elif [[ $# -gt 0 && $var1 = 'dir' ]]
then
  sources="${@}"
else
  sources=( . )
fi
for source in ${sources[@]}
do
  if [[ -d $origin/$source ]]
  then
    for i in `ls -a $origin/$source`
    do
      if [[ -d $origin/$source/$i && -d $origin/$source/$i/.git ]]
      then
        cd $origin/$source/$i
        repo=$(git config --get remote.origin.url)
        printf "%s\n" "${repo##*/}"
        eval "git $gitcmd"
        printf "\n"
        cd $origin
      fi
    done
  elif [[ -z `eval "git $gitcmd $source" 2>&1 | grep "not a git command"` ]]
  then
    gitcmd="$gitcmd $source"
  elif [[ -z `eval "git $source" 2>&1 | grep "not a git command"` ]]
  then
    gitcmd="$gitcmd; git $source"
  fi
done
