#!/usr/bin/env bash

read -p "Enter the return date (YYYY-MM-DD): " returnDate

hostelname=$(tail -1 userDetails.txt | cut -d' ' -f5)
rollno=$(tail -1 userDetails.txt | cut -d' ' -f2)
name=$(tail -1 userDetails.txt | cut -d' ' -f1)

echo Asking for approval...
echo "$name $rollno $returnDate" >> /home/$hostelname/approvalRequests.txt
echo "$name $rollno $returnDate" >> signOutRequests.txt
