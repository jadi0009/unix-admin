#!/bin/bash

root_usage=$(df -Ph | grep " /$" | sed -e "s/ \+/\t/g" | cut -f5)

usage=${root_usage%?}

if [ $usage -lt 80 ]; then
	sendmail  "root" << EOF
subject:disk usage warning
from:system
usage of "/" directory is over 80%
EOF

fi
