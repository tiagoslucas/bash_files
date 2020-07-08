#!/bin/sh
if ! command -v sshpass &>/dev/null;
then
	printf "You have to install sshpass to use vm!\n"
	exit 1
fi

subject=''
host=''
access=''
printf -v newline "\n"

if [[ $# -gt 1 ]]
then
	subject=$1
	access=$2
elif [[ $# -gt 0 ]];
then
	subject=$1
else
	subject=''
fi

touch ~/.servermachines

lines=''
while read i;
do
	if [[ $host == '' ]] && [[ $i == $subject* ]];
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
		lines="${lines}${line:-$i}${newline}"
		unset line
	fi
done < ~/.servermachines

printf "%s" "$lines" > ~/.servermachines

if [[ $access == '' ]] || [[ $host == '' ]];
then
	printf "No matches found!"
	exit 1
fi

sshkey=$(ssh-keyscan "${host##*@}" 2>/dev/null)
while read i;
do
	grep -qxF "$i" ~/.ssh/known_hosts || printf "%s\n" "$i" >> ~/.ssh/known_hosts
done <<< "$sshkey"
env SSHPASS=$access sshpass -e ssh $host
