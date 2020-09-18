#!/bin/bash
if [ -z $(command -v bash) ];
then
  printf "You have to install bash to use vm!\n"
  exit 1
elif [ -z $(command -v sshpass) ];
then
    printf "You have to install sshpass to use vm!\n"
    exit 1
fi

lines=''
printf -v newline "\n"
touch ~/.servermachines

if [[ $# -gt 1 ]]
then
    subject=$1
    access=$2

    sshkey=$(ssh-keyscan "${1##*@}" 2>/dev/null)
    if [[ -n $sshkey ]];
    then
        host=$1
    fi
elif [[ $# -gt 0 ]];
then
    subject=$1
else
    subject=''
fi

if  [[ -n $host ]] && [[ -n $access ]];
then
    oldlines=$(cat ~/.servermachines)
    if [[ -n $oldlines ]];
    then
        oldlines="$oldlines$newline"
    fi
    lines="$oldlines$host%%%$access"
else
    while read -r i;
    do
        if [[ -z $host ]] && [[ $i == $subject* ]];
        then
            host=$(awk -F '%%%' '{print $1}' <<< $i)
            if  [[ -n $access ]];
            then
                line="$host%%%$access"
            else
                access=$(awk -F '%%%' '{print $2}' <<< $i)
            fi
        fi
        if [[ -n $i ]];
        then
            lines="$lines${line:-$i}$newline"
            unset line
        fi
    done < <(grep '' ~/.servermachines)
fi

if [[ -z $access ]] || [[ -z $host ]];
then
    printf "No matches found!\n"
    exit 1
elif [[ ! -n $sshkey ]];
then
    sshkey=$(ssh-keyscan "${host##*@}" 2>/dev/null)
fi

while read -r i;
do
    grep -qxF "$i" ~/.ssh/known_hosts || printf "%s\n" "$i" >> ~/.ssh/known_hosts
done <<< "$sshkey"

env SSHPASS=$access sshpass -e ssh $host
if [[ $? == 0 ]];
then
    printf "%s" "$lines" > ~/.servermachines
fi
