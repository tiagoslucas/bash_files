#!/usr/bin/env sh
echo --% >/dev/null;: ' | out-null
<#'

read -p 'First link: ' first
read -p 'Last link: ' last

if [ -z $(command -v awk) ];
then
  printf "You need awk to run this script!"
  exit 1;
fi

common=$(awk -v fir=$first -v las=$last 'BEGIN{split(fir,first,"/"); split(las,last,"/"); eq=""; for(i=1;i<=length(first);i++){if(first[i] != last[i]){print eq; exit} eq=eq first[i] "/"}}')
range=$(awk -v first=$first -v last=$last -F/ 'BEGIN{printf "{"; $0=first; printf $NF == "" ? $(NF - 1) : $NF; $0=last; printf ".."; printf $NF == "" ? $(NF - 1) : $NF; printf "}"}')

for i in $(eval echo $range);
do
  xdg-open "$common$i";
  sleep 1;
done

exit #>

