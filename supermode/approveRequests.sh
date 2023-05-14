#!/usr/bin/env bash

# So we're duplicating the stdin to fd 4
exec 4<&0

while read -r -a line; do 
    name=${line[0]}
    rollno=${line[1]}
    returnDate=${line[2]}
    echo Preparing to approve student $name

    echo -n "Approve $rollno $name to return on $returnDate? (Y/N): " 
    # and reading from the duplicate stdin cuz
    # the current stdin is reading from the file

    # IT TOOK ME 2 HOURS TO FIGURE THIS OUT
    # I HATE BASH WITH A PASSION
    # I WOULD'VE DONE THIS SHIT IN 10 MINS WITH PYTHON
    # MYYYYY GOOOOOOOOOOOOOD
    # but hey it works now
    # oh hi mentor going through my code :)
    read -r approval <&4
    if [[ $approval == "Y" || $approval == "y" ]]; then
        echo "$name $rollno $returnDate" >> approvedSignOutRequests.txt
    fi
done < approvalRequests.txt

# Once approvals are done, we clear the current "queue"
> approvalRequests.txt