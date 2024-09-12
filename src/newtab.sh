#!/usr/bin/env sh
echo --% >/dev/null;: ' | out-null
<#'
command -v awk &>/dev/null || (echo "You need awk to run this script! \n" && exit)

read -p 'First link: ' first
read -p 'Last link: ' last
common=$(awk -v fir=$first -v las=$last 'BEGIN{split(fir,first,"/");split(las,last,"/");eq="";for(i=1;i<=length(first);i++){if(first[i]!=last[i]){print eq;exit}eq=eq first[i] "/"}}')
range=$(awk -v first=$first -v last=$last -F/ 'BEGIN{printf "{";$0=first;printf $NF==""?$(NF-1):$NF;$0=last;printf "..";printf $NF==""?$(NF-1):$NF;printf "}"}')

for i in $(eval echo $range);
do
  xdg-open "$common$i";
  sleep 1;
done
exit #>

$First = Read-Host -Prompt 'First link: '
$Last = Read-Host -Prompt 'Last link: '
$Common=($prefixLength=0;$maxLength=[Math]::Min($First.Length,$Last.Length);for($i=0;$i -lt $maxLength;$i++){if($First[$i] -eq $Last[$i]){$prefixLength=$i+1}else{break}};$First.Substring(0,$prefixLength))
$Range=[int]($First -replace '.+?(\d+)[\/]?$','$1')..[int]($Last -replace '.+?(\d+)[\/]?$','$1')

$Range | % { Start-Process "$Common$_"; Start-Sleep 1 }
Exit
