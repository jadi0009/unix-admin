#!/bin/bash
# Harry Cui   


allusers=(mscott dschrute jhalpert tflenderson dphilbin mpalmer pbeesly cbratton amartin kkapoor abernard kmalone omartinez plapin shudson hcui)
#echo ${allusers[*]}
echo "adding users ...."

managersg=(mscott dschrute jhalpert)

salesg=(abernard plapin shudson)

accountingg=(amartin kmalone omartinez)


for i in ${allusers[*]}; do
	useradd -m $i -p saclass 

done
echo "add users done !"

######################### add  groups ############################

groupadd managers
groupadd sales
groupadd accounting

for i in ${managersg[*]}; do
	usermod -G managers $i

done

for i in ${salesg[*]}; do
	usermod -G sales $i

done

for i in ${accountingg[*]}; do
	usermod -G accounting $i

done

echo "add groups done !"



######################## group shared directory#####################

if [ "$HOSTNAME" = "MachineE.localdomain" ]; then
	mkdir /home/managers   /home/sales    /home/accounting
	chown root:managers /home/managers
	chown root:sales /home/sales
	chown root:accounting /home/accounting

	chmod 2070 /home/managers /home/sales  /home/accounting

	echo "shared folders done!"

fi

exit









