#!/bin/bash

#Project 3

newline(){
	echo " "
	echo "------------------" >> scriptlog.txt
}

#sudo apt-get update
#sudo apt-get install nis
#sudo apt-get install sysv-rc-conf


### BEGIN MODIFYING NSSWITCH.CONF ##############

echo "NSSWITCH.CONF is changing..."
echo "NSSWITCH.CONF is changing from..." >> scriptlog.txt
cat nsswitch >> scriptlog.txt
newline

sed -i '/passwd:         compat/s/$/ nis/' nsswitch
sed -i '/group:          compat/s/$/ nis/' nsswitch
sed -i '/shadow:         compat/s/$/ nis/' nsswitch
sed -i 's|hosts:          files dns|hosts:          files nis dns |g' nsswitch

echo "NSSWITCH.CONF CHANGED!! "
echo "NSSWITCH.CONF CHANGED!! " >> scriptlog.txt
cat nsswitch >> scriptlog.txt
newline
echo "End of modifying nsswitch.conf "
echo "End of modifying nsswitch.conf " >> scriptlog.txt
echo " "
newline
### END MODIFYING NSSWITCH.CONF ###############

### BEGIN MODIFYING /etc/yp.conf ##############
echo "YP.CONF is changing!! "
echo "YP.CONF is changing!! " >> scriptlog.txt
cat yp >> scriptlog.txt
newline
sed -i '/com/a\
ypserver 10.0.0.1\' yp

echo "YP.CONF has changed" >> scriptlog.txt
echo "YP.CONF has changed"
cat yp >> scriptlog.txt
newline
### END MODIFYING /etc/yp.conf ########
### RESTART NIS #######################

echo "RESTARTING NIS" >> scriptlog.txt
echo "RESTARTING NIS"
newline
echo "DEBUG MAKE SURE ITS UNCOMMENTED"
newline
echo "DEBUG MAKE SURE ITS UNCOMMENTED" >> scriptlog.txt
newline

#sudo service ypbind restart
#sudo service sysv-rc-conf ypbind on

### END RESTART NIS ###################
### START NFS INSTALL ################

echo "INSTALLING NFS" >> scriptlog.txt
echo "INSTALLING NFS"
newline
#sudo apt-get update
#sudo apt-get install nfs-common
#sudo apt-get install nfs-kernel-server
newline
echo "END OF INSTALLATION OF NFS"
echo "END OF INSTALLATION OF NFS" >> scriptlog.txt
newline
### END NFS INSTALLATION ##############
#######################################
#######################################
echo "PROJECT 4"
echo "PROJECT 4" >> scriptlog.txt
newline
# PROJECT 4

echo "INSTALLING AUTOFS"
echo "INSTALLING AUTOFS" >> scriptlog.txt
newline
#sudo apt-get install autofs
echo "MOVING home to home.itvm25-4b"
echo "MOVING home to home.itvm25-4b" >> scriptlog.txt
#sudo mv /home /home.itvm25-4b
newline
echo "MAKING NEW HOME"
echo "MAKING NEW HOME" >> scriptlog.txt
#sudo mkdir /home
newline

### BEGIN MODYFING /etc/passwd ########

echo "MODIFYING passwd"
echo "MODIFYING passwd" >> scriptlog.txt
newline
sed -i 's|sysadmin:x:1000:1000:itvm25-4b,,,:/home/sysadmin:/bin/bash|sysadmin:x:1000:1000:sysadmin,,,:/home.itvm25-4b/sysadmin:/bin/bash|g' passwd
echo "END OF passwd CHANGE"
newline
echo "END OF passwd CHANGE" >> scriptlog.txt
newline
### END MODIFYING /etc/passwd #########
