#!/usr/bin/env bash

# Give HAD rwx to all hostels
for hostelname in GarnetA GarnetB Agate Opal; do 
    # Recursively give rwx access to everything in the hostel to the HAD
    sudo setfacl -Rm HAD:rwx /home/$hostelname

    # The respective warden can access only their hostel
    sudo setfacl -Rm $hostelname:rwx /home/$hostelname

    # Give read access to hostel students only to the important files
    sudo setfacl -m g:${hostelname}Student:r-x /home/$hostelname
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/announcements.txt
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/feeDefaulters.txt
    sudo setfacl -m g:${hostelname}Student:-w- /home/$hostelname/approvalRequests.txt
    sudo setfacl -m g:${hostelname}Student:r-- /home/$hostelname/approvedSignOutRequests.txt
    sudo setfacl -m g:${hostelname}Student:-w- /home/$hostelname/signOutDefaulters.txt

    for d in /home/$hostelname/*; do
        # Check if the current item is a directory
         if [ -d "$d" ]; then
            # Set the ACL for the directory to allow read-only access for the group
            setfacl -m g:${hostelname}Student:r-x $d
        fi
    done

    # Give students write access to mess.txt inside HAD
    sudo setfacl -m g:${hostelname}Student:r-x /home/HAD
    sudo setfacl -m g:${hostelname}Student:-w- /home/HAD/mess.txt
done