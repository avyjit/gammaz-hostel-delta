#!/usr/bin/env bash

checkSignOut() {
    # Check if there are any sign out requests at all
    # We do this by checking if signOutRequests.txt is non-empty
    lineCount=$(wc -l $HOME/signOutRequests.txt | cut -d' ' -f1)

    # If lineCount is not 0, check whether it is present
    # in the warden's approved requests
    if [ "$lineCount" != 0 ]; then
        lastRequest=$(tail -1 $HOME/signOutRequests.txt)
        echo Checking last signout request $lastRequest
        hostelname=$(tail -1 $HOME/userDetails.txt | cut -d' ' -f5)

        # Check if this is present in the approved requests
        if grep -q "$lastRequest" /home/$hostelname/approvedSignOutRequests.txt; then
            echo "Request was approved!"
        else
            # Add to defaulters
            echo "Adding to defaulters..."
            echo $lastRequest >> /home/$hostelname/signOutDefaulters.txt
        fi
    else
        echo "No signout requests!"
    fi

    > $HOME/signOutRequests.txt
}

checkSignOut