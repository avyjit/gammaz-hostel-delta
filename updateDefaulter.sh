#!/usr/bin/env bash

semester=$1
deadline=$2

for student in $(find . -name userDetails.txt); do
    feesFile=$(echo $student | sed -e 's/userDetails.txt/fees.txt/')
    rollno=$(tail -1 $student | cut -d' ' -f2)
    if [ ! $semester -eq $(tail +6 "$feesFile" | wc -l) ]; then
        echo $rollno >> ./feeDefaulters.txt
    fi 
done