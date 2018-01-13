#!/bin/bash

#Project 3

#sudo apt-get update
#sudo apt-get install nis
#sudo apt-get install sysv-rc-conf


### BEGIN MODIFYING NSSWITCH.CONF ##############

sed -i '/passwd:         compat/s/$/ nis/' nsswitch
sed -i '/group:          compat/s/$/ nis/' nsswitch
sed -i '/shadow:         compat/s/$/ nis/' nsswitch
sed -i 's|hosts:          files dns|hosts:          files nis dns |g' nsswitch

### END MODIFYING NSSWITCH.CONF ###############

### BEGIN MODIFYING /etc/yp.conf ##############

sed -i '/com/a\
ypserver 10.0.0.1\' yp

### END MODIFYING /etc/yp.conf ########
### RESTART NIS #######################

#sudo service ypbind restart
#sudo service sysv-rc-conf ypbind on

### END RESTART NIS ###################
### START NFS INSTALL ################

#sudo apt-get update
#sudo apt-get install nfs-common
#sudo apt-get install nfs-kernel-server

### END NFS INSTALLATION ##############
#######################################
#######################################

# PROJECT 4

#sudo apt-get install autofs
#sudo mv /home /home.itvm24-4b
#sudo mkdir /home

### BEGIN MODYFING /etc/passwd ########

sed -i 's|sysadmin:x:1000:1000:sysadmin,,,:/home/sysadmin:/bin/bash|sysadmin:x:1000:1000:sysadmin,,,:/home.itvm25-4b/sysadmin:/bin/bash|g' passwd

### END MODIFYING /etc/passwd #########




