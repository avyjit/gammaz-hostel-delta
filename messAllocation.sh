#!/usr/bin/env bash
if [ "$USER" = "HAD" ]; then
    echo "Current user: HAD"
else 
    echo "Please enter your preferred order for three messes (1, 2, 3):"
    read messpref 

    awk -i inplace 'NR==1 {print} NR>1 {print $1,$2,$3,$4,$5,$6,$7,"'$messpref'"}' userDetails.txt
    
fi