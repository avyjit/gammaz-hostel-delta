#!/usr/bin/env bash

detailsfile="sysad-task1-studentDetails.txt"

getRowByRollNo() {
    # Filters the input file by rollno
    # Since rollno.s are unique, only one row is returned
    grep -i "$1" $detailsfile
}

getDept() {
    # Only the first 4 characters of the rollno are required
    # to identify the department
    local deptid=$(cut --characters=1-4 <<< $1)
    case $deptid in
        1061) echo "CSE" ;;
        1021) echo "Chem" ;;
        1031) echo "Civil" ;;
        1071) echo "EEE" ;;
        1081) echo "ECE" ;;
        1101) echo "ICE" ;;
        1111) echo "Mech" ;;
        1121) echo "MME" ;;
        1141) echo "Prod" ;;
        1011) echo "Arch" ;;
        *) echo "Invalid Dept ID" ;;
    esac
}

# Gets the current year
getYear() {
    local year=$(date +%Y)
    echo $year
}

# Gets the current month
getMonth() {
    local month=$(date +%m)
    case $month in
        01) echo "Jan" ;;
        02) echo "Feb" ;;
        03) echo "Mar" ;;
        04) echo "Apr" ;;
        05) echo "May" ;;
        06) echo "Jun" ;;
        07) echo "Jul" ;;
        08) echo "Aug" ;;
        09) echo "Sep" ;;
        10) echo "Oct" ;;
        11) echo "Nov" ;;
        12) echo "Dec" ;;
    esac
}

getDept 112122021
getYear
getMonth
