#!/bin/bash

# dashboard brief overview of the current  system

##### Constants

TITLE="System Information for $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"

##### Functions


CPU=$(top bn1 | grep "load" | cut -f3,4,5 -d ",")
FREEMEM=$(free -m | grep "Mem" | sed -e "s/ \+/\t/g" | cut -f4)
ALLMEM=$(free -m | grep "Mem" | sed -e "s/ \+/\t/g" | cut -f2)

ETHES=$(ifconfig | grep "Link encap" | cut -f1 -d\ )




system_info()
{
	echo "CPU AND MEMORY RESOURCES ---------------------------------------------"
	echo "CPU $CPU                              Free Memory: $FREEMEM MB/ $ALLMEM MB"

}




network_stat()
{
	echo "NETWORK CONNCETIONS ---------------------------------------------"
	for i in $(ETHES); do
		ifconfig $i | grep "RX bytes" | sed -e "s/ \+RX bytes/$i Bytes Received/g" -e "s/TX bytes/  Bytes Transmitted/g"
	done
}


home_space()
{
	echo "ACCOUNT INFORMATION ---------------------------------------------"
	echo "Total users: $(cat /etc/passwd | wc -l)        number active: $(who | wc -l)"
	echo "Most frequently used shell:     $(cat /etc/passwd | cut -d: -f7 |sort | uniq -c | sort | head -n1 | sed -e "s/^.\+ \([^ ]\+\)$/\\1/g")"
}

##### Main

cat <<- _EOF_

      $TITLE
      $TIME_STAMP
      $(system_info)
      $(network_stat)
      $(home_space)
  
_EOF_