#!/usr/bin/env bash

# Import utility functions
. ./utils.sh

detailsfile=$1

# If no argument is passed, use the default
# student details file
if [ -z $detailsfile ]; then
    detailsfile="./data/testdata.txt"
fi

# Create the HAD account
sudo useradd -d /home/HAD -m HAD


# Create hostel accounts
for hostelname in GarnetA GarnetB Agate Opal; do 
    sudo groupadd ${hostelname}Student 
    sudo useradd -d /home/$hostelname -m $hostelname

    sudo touch /home/$hostelname/announcements.txt
    sudo touch /home/$hostelname/feeDefaulters.txt
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

    sudo useradd -d /home/$hostel/$room/$name -m $name
    usermod -a -G ${hostel}Student $name

    sudo touch /home/$hostel/$room/$name/userDetails.txt
   	sudo touch /home/$hostel/$room/$name/fees.txt	

    echo "Name RollNumber Dept Year Hostel AllocatedMess Month MessPref" | sudo tee -a /home/$hostel/$room/$name/userDetails.txt > /dev/null
    echo "$name $rollno $dept $year $hostel $mess $month $messpref" | sudo tee -a /home/$hostel/$room/$name/userDetails.txt > /dev/null
done <<< "$(skipFirstLine $detailsfile)"