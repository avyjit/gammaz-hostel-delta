#!/usr/bin/env bash

# Import utility functions
. ./utils.sh

detailsfile=$1

# If no argument is passed, use the default
# student details file
if [ -z $detailsfile ]; then
    detailsfile="./data/testdata.txt"
fi



for hostelname in GarnetA GarnetB Agate Opal; do 
    echo "$hostelname"
done

while read -r -a line; do
    name=${line[0]}
    rollno=${line[1]}
    hostel=${line[2]}
    room=${line[3]}
    mess=${line[4]}
    messpref=${line[5]}
    dept=$(getDept $rollno)
    year=$(getYear)
    month=$(getMonth)

    echo "$name $rollno $dept $year $hostel $mess $month $messpref"
done <<< "$(skipFirstLine $detailsfile)"