#! /bin/bash

units=( zero one two three four five six seven eight nine )
tens=( Ten Twenty Thirty Fourty Fifty Sixty Seventy Eighty Ninety )
teen=( Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen )
string_one="bottles of beer on the wall"
string_two="bottles of beer"
poem(){
    number="${1}"
    number=$(echo ${1:0:1}|tr [a-z] [A-Z])
    number="${number}${1:1}"
    next_number=$(echo ${2:0:1}|tr [a-z] [A-Z])
    next_number="${next_number}${2:1}"
    suffix=""
    [ "$number" != "one" ] && suffix="s"

    echo "
    $number bottle${suffix} of beer on the wall,
    $number bottle${suffix} of beer,
    You take one down and pass it around,
    ${next_number} bottle${suffix} of beer on the wall.

    "
    sleep 0.5
}
counter=0
numbers=( )
for i in {8..1};do
    for j in {9..1};do
	number="${tens[i]} ${units[j]}"
	numbers[$counter]="$number"
	counter=$((counter+1))
    done
    numbers[$counter]="${tens[i]}"
    counter=$((counter+1))
done
for i in {8..0};do
    numbers[$counter]="${teen[i]}"
    counter=$((counter+1))
done
numbers[$counter]="Ten"
counter=$((counter+1))
for i in {9..1};do
    numbers[$counter]="${units[i]}"
    counter=$((counter+1))
done

counter=1
for i in "${numbers[@]}"; do
    if [ $counter -ne ${#numbers[@]} ];then
	poem "${i}" "${numbers[$counter]}"
    else
	poem "${i}" "THERE ARE NO GODDAM"
    fi
    counter=$((counter+1))
done
