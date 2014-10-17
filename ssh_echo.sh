#!/bin/bash

shuf -n 1 /etc/passwd | cut -f1 -d: | xargs -I user ssh user@100.64.0.53 'cat /etc/passwd | grep -P "^user"'



