#!/usr/bin/env bash

# We're hardcoding the fee amount here because it was not mentioned in the task
feeAmount=100000

while read -r line; do
    # Extract the fee name and percentage from the current line
    feeName=$(echo "$line" | awk '{print $1}')

    # tr -d is to remove the trailing % symbol
    feePercentage=$(echo "$line" | awk '{print $2}' | tr -d '%')

    # Calculate the amount to add to the corresponding fee in fees.txt
    amountToAdd=$(echo "$feeAmount * $feePercentage / 100" | bc)

    # Every iteration we're making a new temp fail, updating
    # only one line and then copying it back.

    # Stupidly inefficient? Yep. Does it work? Yes. Sorry Delta Mentors
    # for putting you through this monstrosity. O(n^2) lol
    awk -v name="$feeName" -v amount="$amountToAdd" '{
    if ($1 == name) {
        $2 += amount
    }
    print
    }' fees.txt >fees.txt.tmp
    mv fees.txt.tmp fees.txt
done <feeBreakup.txt

echo "$(date +'%Y-%m-%d')" >>fees.txt
