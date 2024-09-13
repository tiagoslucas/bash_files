#!/usr/bin/env sh
echo --% >/dev/null;: ' | out-null
<#'
command -v awk >/dev/null 2>&1 || (echo "You need awk to run this script! \n" && exit)
command -v xdg-open >/dev/null 2>&1 && command="xdg-open" || command="open"

read -p 'First link: ' first
read -p 'Last link: ' last
common=$(awk -v fir=$first -v las=$last 'BEGIN{split(fir,first,"/");split(las,last,"/");eq="";for(i=1;i<=length(first);i++){if(first[i]!=last[i]){print eq;exit}eq=eq first[i] "/"}}')
range=$(awk -v first=$first -v last=$last -F/ 'BEGIN{printf "{";$0=first;printf $NF==""?$(NF-1):$NF;$0=last;printf "..";printf $NF==""?$(NF-1):$NF;printf "}"}')

for i in $(eval echo $range);
do
  eval "$command $common$i";
  sleep 1;
done
exit #>

Write-Host 'First link: ' -NoNewLine; $First = Read-Host
Write-Host 'Last link: ' -NoNewLine; $Last = Read-Host
$Common=$($prefixLength=0;$maxLength=[Math]::Min($First.Length,$Last.Length);for($i=0;$i -lt $maxLength;$i++){if($First[$i] -eq $Last[$i]){$prefixLength=$i+1}else{break}};$First.Substring(0,$prefixLength))
$Range=[int](($First -split '/' | Where-Object {$_} | Select-Object -Last 1))..[int](($Last -split '/' | Where-Object {$_} | Select-Object -Last 1))

$Range | % { Start-Process ($Common.Substring(0,$Common.LastIndexOf('/')) + "/$_"); Start-Sleep 1 }
Exit
