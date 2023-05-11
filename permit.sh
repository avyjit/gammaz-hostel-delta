#!/usr/bin/env bash

# Give HAD rwx to all hostels
for hostelname in GarnetA GarnetB Agate Opal; do 
    sudo setfacl -Rm HAD:rwx /home/$hostelname

    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/announcements.txt
    #sudo setfacl -m HAD:rwx /home/$hostelname/announcements.txt

    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/feeDefaulters.txt
    #sudo setfacl -m HAD:rwx /home/$hostelname/feeDefaulters.txt

    #for i in $(grep ${hostelname}Student /etc/group | cut -d ":" -f 4 | sed 's/,/ /g'); do
        #homedir=$(getent passwd $i | cut -d: -f6)
        #sudo setfacl -m HAD:rwx $homedir
        #sudo setfacl -m HAD:rwx $homedir/fees.txt
        #sudo setfacl -m HAD:rwx $homedir/
    #done


done