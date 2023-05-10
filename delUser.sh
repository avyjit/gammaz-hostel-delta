sudo userdel -r HAD

for hostelname in GarnetA GarnetB Agate Opal; do 
    for i in $(grep ${hostelname}Student /etc/group | cut -d ":" -f 4 | sed 's/,/ /g'); do
        sudo userdel -r $i
    done

    sudo userdel -r $hostelname
    sudo groupdel ${hostelname}Student
done