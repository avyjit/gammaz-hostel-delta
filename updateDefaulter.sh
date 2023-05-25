#!/usr/bin/env bash

semester=$1
deadline=$2

touch paid.tmp.txt

for student in $(find . -name userDetails.txt); do
    feesFile=$(echo $student | sed -e 's/userDetails.txt/fees.txt/')
    rollno=$(tail -1 $student | cut -d' ' -f2)
    name=$(tail -1 $student | cut -d' ' -f1)
    if [ ! $semester -eq $(tail +6 "$feesFile" | wc -l) ]; then
        #echo adding $rollno to defaulters due to sem
        echo $rollno $name >> ./feeDefaulters.txt
    elif [[ $(tail -1 $feesFile) > $deadline ]]; then
        #echo adding $rollno to defaulters due to deadline
        echo $rollno $name >> ./feeDefaulters.txt
    else
        echo $rollno $name $(tail -1 $feesFile) >> ./paid.tmp.txt
    fi
done

sort -k3 paid.tmp.txt | head -n 5 >> announcements.txt
rm paid.tmp.txt 