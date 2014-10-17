#!/bin/bash
# Harry Cui	hecu9011@colorado.edu   lab5

#umask on ABCDE
echo "umask 007" >> /etc/profile



#Meredith Palmer FTP server
#access


if [ "$HOSTNAME" = "MachineC.localdomain" ]; then
	chgrp -R mpalmer /var/ftp 
	chmod g+rwxs /var/ftp

	echo "-:ALL EXCEPT mpalmer dschrute hcui shutdown sync:LOCAL" >> /etc/security/access.conf

	
	cd /etc/pam.d/
	rm /etc/pam.d/system-auth
	ln -f -s system-auth-admin system-auth

fi


#Pam Beesly, Kelly Kapoor, and Andy Bernard  Webserver
#access


if [ "$HOSTNAME" = "MachineB.dundermifflin.com" ]; then
	groupadd webteam
	usermod -a -G webteam pbeesly
	usermod -a -G webteam kkapoor 
	usermod -a -G webteam abernard
	chgrp -R webteam  /var/www/html
	chmod g+rwxs   /var/www/html
	chmod  o+r  /var/www/html

	echo "-:ALL EXCEPT pbeesly kkappor abernard dshrute hcui shutdown sync:LOCAL" >> /etc/security/access.conf

	
	cd /etc/pam.d/
	rm /etc/pam.d/system-auth
	ln -f -s system-auth-admin system-auth

fi


#access

if [ "$HOSTNAME" = "MachineD.localdomain" ]; then

	echo "-:ALL EXCEPT  dshrute hcui shutdown sync:LOCAL" >> /etc/security/access.conf

	
	cd /etc/pam.d/
	rm /etc/pam.d/system-auth
	ln -f -s system-auth-admin system-auth

fi


#access

if [ "$HOSTNAME" = "MachineE.localdomain" ]; then
	echo "-:ALL EXCEPT  dshrute hcui shutdown sync:LOCAL" >> /etc/security/access.conf

	cd /etc/pam.d/
	rm /etc/pam.d/system-auth
	ln -f -s system-auth-admin system-auth

fi


#send to machinesBCDE
if [ "$HOSTNAME" = "MachineA.localdomain" ]; then
	echo "Machine E"
	scp /etc/pam.d/system-auth-admin   root@10.21.32.2:/etc/pam.d/
	scp /etc/sudoers  root@10.21.32.2:/etc/sudoers     
	
	echo "Machine B"
	scp /etc/pam.d/system-auth-admin   root@100.64.53.2:/etc/pam.d/
	scp /etc/sudoers  root@100.64.53.2:/etc/sudoers     
	
	echo "Machine C"
	scp /etc/pam.d/system-auth-admin   root@100.64.53.3:/etc/pam.d/
	scp /etc/sudoers  root@100.64.53.3:/etc/sudoers     
	
	echo "Machine D"
	scp /etc/pam.d/system-auth-admin   root@100.64.53.4:/etc/pam.d/
	scp /etc/sudoers  root@100.64.53.4:/etc/sudoers    
	
	

	cd /etc/pam.d/
	rm /etc/pam.d/system-auth
	ln -f -s system-auth-admin system-auth

fi











