#!/usr/bin/env bash

# Import utility functions
. ./utils.sh

detailsfile=$1

# If no argument is passed, use the default
# student details file
if [ -z $detailsfile ]; then
    detailsfile="./data/testdata.txt"
fi

while read -r -a line; do
    name=${line[0]}
    rollno=${line[1]}
    hostel=${line[2]}
    room=${line[3]}
    mess=${line[4]}
    messpref=${line[5]}
    dept=$(getDept $rollno)
    year=$(getYear)

    echo "$name ($rollno) is a $dept student of $hostel"
done <<< "$(skipFirstLine $detailsfile)"