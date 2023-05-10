#!/usr/bin/env bash

# Give HAD rwx to all hostels
for hostelname in GarnetA GarnetB Agate Opal; do 
    sudo setfacl -m HAD:rwx /home/$hostelname
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/announcements.txt
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/feeDefaulters.txt
done