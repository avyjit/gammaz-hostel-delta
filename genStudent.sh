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
sudo useradd -s /bin/bash -d /home/HAD -m HAD
sudo cp ./data/mess.txt /home/HAD/mess.txt
sudo cp ./messAllocation.sh /home/HAD/messAllocation.sh
# Add messAllocation.sh to alias
echo "alias messAllocation='~/messAllocation.sh'" | sudo tee -a /home/HAD/.bashrc >/dev/null
sudo chown HAD /home/HAD/mess.txt
sudo chmod +x *.sh

# DEBUG ONLY
echo "HAD:0" | sudo chpasswd

# Create hostel accounts
for hostelname in GarnetA GarnetB Agate Opal; do
    sudo groupadd ${hostelname}Student
    sudo useradd -s /bin/bash -d /home/$hostelname -m $hostelname

    sudo touch /home/$hostelname/announcements.txt
    sudo touch /home/$hostelname/feeDefaulters.txt

    sudo touch /home/$hostelname/approvalRequests.txt
    sudo touch /home/$hostelname/approvedSignOutRequests.txt
    sudo touch /home/$hostelname/signOutDefaulters.txt

    sudo cp ./updateDefaulter.sh /home/$hostelname/updateDefaulter.sh
    sudo cp ./supermode/approveRequests.sh /home/$hostelname/approveRequests.sh

    # Add updateDefaulter.sh to alias
    echo "alias updateDefaulter='~/updateDefaulter.sh'" | sudo tee -a /home/$hostelname/.bashrc >/dev/null
    echo "alias approveRequests='~/approveRequests.sh'" | sudo tee -a /home/$hostelname/.bashrc >/dev/null

    sudo chown -R $hostelname /home/$hostelname
    chmod +x /home/$hostelname/*.sh

    # DEBUG ONLY
    echo "$hostelname:0" | sudo chpasswd
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

    sudo useradd -s /bin/bash -d /home/$hostel/$room/$name -m $name
    usermod -a -G ${hostel}Student $name

    sudo cp ./data/feeBreakup.txt /home/$hostel/$room/$name/feeBreakup.txt

    sudo touch /home/$hostel/$room/$name/userDetails.txt
    echo "Name RollNumber Dept Year Hostel AllocatedMess Month MessPref" | sudo tee -a /home/$hostel/$room/$name/userDetails.txt >/dev/null
    echo "$name $rollno $dept $year $hostel $mess $month $messpref" | sudo tee -a /home/$hostel/$room/$name/userDetails.txt >/dev/null

    sudo touch /home/$hostel/$room/$name/fees.txt
    sudo awk '{print $1" 0"}' ./data/feeBreakup.txt >/home/$hostel/$room/$name/fees.txt
    echo "---" | sudo tee -a /home/$hostel/$room/$name/fees.txt >/dev/null

    sudo cp ./feeBreakup.sh /home/$hostel/$room/$name/feeBreakup.sh
    sudo cp ./messAllocation.sh /home/$hostel/$room/$name/messAllocation.sh
    sudo cp ./supermode/signOut.sh /home/$hostel/$room/$name/signOut.sh
    sudo cp ./supermode/checkSignOut.sh /home/$hostel/$room/$name/checkSignOut.sh

    # Add aliases to .bashrc
    echo "alias feeBreakup='~/feeBreakup.sh'" | sudo tee -a /home/$hostel/$room/$name/.bashrc >/dev/null
    echo "alias messAllocation='~/messAllocation.sh'" | sudo tee -a /home/$hostel/$room/$name/.bashrc >/dev/null
    echo "alias signOut='~/signOut.sh'" | sudo tee -a /home/$hostel/$room/$name/.bashrc >/dev/null

    # Add checkSignOut.sh to ~/.bashrc for automatic check
    cat ./supermode/checkSignOut.sh | sudo tee -a /home/$hostel/$room/$name/.bashrc >/dev/null

    # For signout requests
    sudo touch /home/$hostel/$room/$name/signOutRequests.txt


    sudo chown -R $name /home/$hostel/$room/$name
    sudo chown $hostel /home/$hostel/$room
    sudo chmod +x /home/$hostel/$room/$name/*.sh

    # ONLY FOR DEBUG PURPOSES
    echo "$name:0" | sudo chpasswd

done <<<"$(skipFirstLine $detailsfile)"