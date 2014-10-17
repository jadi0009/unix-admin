#!/bin/bash
#Harry Cui

history | cut -c8- | cut -f1 -d\  | sort | uniq -c | sort -n | tail -n10


cat /etc/passwd | cut -d ‘:’ -f7 | sort | uniq -c


ps aux | cut -f1 -d “ ” | sort | uniq -c


file* | sed-e’s/:*/:/g’ | cut-d:-f2|sort|uniq-c


cat /etc/passwd | sed “s/:/\t/g” | cut -f1,3 | sort +1 -2 | uniq -f1 —all-repeated=separate