#!/usr/bin/env bash
if [ "$USER" = "HAD" ]; then
    declare -A capacities

    while read -r -a line; do
        #echo $line
        mess=${line[0]}
        capacity=${line[1]}
        #echo $mess has capacity $capacity
        capacities[$mess]=$capacity
    done <<< $(head -4 /home/HAD/mess.txt | tail -3)

    # Start reading students from line 6
    lines=$(tail -n +6 /home/HAD/mess.txt)

    while read -r -a line; do
        rollno=${line[0]}
        name=${line[1]}
        hostel=${line[2]}

        echo Current student: $rollno $name $hostel

        # Find the home directory of the student
        homedir=$(find /home/"$hostel" -type d -name "$name")
        echo homedir found is $homedir
        messpref=$(awk 'NR>1 {print $8,$9,$10}' "$homedir"/userDetails.txt)
        
        for mess in $messpref; do
            # Check if there is enough capacity is left
            # from the capacties array
            if [ "${capacities[$mess]}" -gt 0 ]; then
                echo Allocating mess $mess to $name
                awk -i inplace -v allocatedmess="$mess" 'NR==1 {print} NR>1 {$6=allocatedmess; print}' "$homedir"/userDetails.txt
                capacities[$mess]=$((capacities[$mess]-1))
                for i in "${!capacities[@]}"; do
                    echo $i ${capacities[$i]}
                done
                break
            fi
        done
        
        
    done <<< $lines

else 
    echo "Please enter your preferred order for three messes (1, 2, 3):"
    read messpref 

    awk -i inplace -v messpref="$messpref" 'NR==1 {print} NR>1 {print $1,$2,$3,$4,$5,$6,$7,messpref}' userDetails.txt
    awk 'NR>1 {print $2,$1,$5}' userDetails.txt >> /home/HAD/mess.txt
fi