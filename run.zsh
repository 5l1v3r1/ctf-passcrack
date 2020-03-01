#!/usr/bin/env zsh
rm -rf input output &> /dev/null
mkfifo input
mkfifo output
tail -f input | nc ctfchallenges.ritsec.club 8080 > output &
while read -r line
do
    if echo $line | grep -q 'moron'
    then
        continue
    elif echo $line | grep -q 'meantime'
    then
        continue
    elif echo $line | grep -q 'However'
    then
        continue
    elif echo $line | grep -q 'Good job'
    then
        echo $line
        continue
    elif echo $line | grep -q 'Oof'
    then
        echo "FAIL!"
        break
    elif echo $line | grep -q 'NICE'
    then
        echo $line
        break
    fi
    echo $line
    if echo $line | grep -qF '$'
    then
        result=$(./crypt-crack $line ./biglist.ls)
        echo "Crypt pass = \"$result\""
        echo $result > input
    else
        result=$(./ntlm-crack.py $line ./biglist.ls)
        echo "NTLM pass = \"$result\""
        echo $result > input
    fi
done < output
rm -rf input output
exit 0
