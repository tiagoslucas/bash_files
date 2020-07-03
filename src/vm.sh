#!/bin/bash
if ! command -v sshpass &>/dev/null;
then
	printf "You have to install sshpass to use vm!\n"
	exit 1
fi

subject=''
host=''
access=''

if [[ $# -gt 0 ]];
then
	subject=$1
else
	subject=''
fi

touch ~/.servermachines

while read i;
do
	if [[ $i == $subject* ]];
	then
		host=$(echo -n $i | awk -F "%%%" '{print $1}')
		access=$(echo -n $i | awk -F "%%%" '{print $2}')
		break
	fi
done < ~/.servermachines

if [[ $access == '' ]] || [[ $host == '' ]];
then
	echo "No matches found!"
	exit 1
fi

env SSHPASS=$access sshpass -e ssh $host
