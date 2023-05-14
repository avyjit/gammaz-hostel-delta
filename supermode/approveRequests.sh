#!/usr/bin/env bash

while read -r -a line; do 
    name=${line[0]}
    rollno=${line[1]}
    returnDate=${line[2]}

    read -r -p "Approve $rollno $name to return on $returnDate? (Y/N): " approval
    if [[ $approval == "Y" || $approval == "y" ]]; then
        echo "$name $rollno $returnDate" >> approvedSignOutRequests.txt
    fi
done <<< approvalRequests.txt

# Once approvals are done, we clear the current "queue"
> approvalRequests.txt