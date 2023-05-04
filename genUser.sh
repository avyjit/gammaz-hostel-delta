#!/usr/bin/env bash


detailsfile=$1

# If no argument is passed, use the default
# student details file
if [ -z $detailsfile ]; then
    detailsfile="./data/sysad-task1-studentDetails.txt"
fi

