#!/bin/bash

#!/bin/bash
[ "$UID" -eq 0 ] || { echo "This script must be run as root. Please type 'sudo' first then the path to the script."; exit 1;}

echo Sudo Authenticated.



NC='\033[0m' # No Color
RED='\033[0;31m'
VAR=scriptlog

new_line() {
echo '---------------------------------------------'
}

log() {
	new_line | tee -a $VAR.txt
	echo $1 | tee -a $VAR.txt
	new_line | tee -a $VAR.txt
}

log_cat() {
	new_line | tee -a $VAR.txt
	cat $1 | tee -a $VAR.txt
	new_line | tee -a $VAR.txt
}

log_append() {
	echo $1 >> $2 | tee -a $VAR.txt
}

sed -i '/ubuntu/a\ \
#Gateway\
10.0.0.1 it20.it.cs.umb.edu it20\
 \
# The following lines are desirable for IPv6 capable hosts\
::1     localhost ip6-localhost ip6-loopback\
fe00::0 ip6-localnet\
ff00::0 ip6-mcasterprefix\
ff02::1 ip6-allnodes\
ff02::2 ip6-allrouters\
 \
#Virtual Machines\
10.0.0.160 itvm21-3a.it.cs.umb.edu itvm21-3a\
10.0.0.161 itvm22-3a.it.cs.umb.edu itvm22-3a\
10.0.0.162 itvm23-3a.it.cs.umb.edu itvm23-3a\
10.0.0.163 itvm24-3a.it.cs.umb.edu itvm24-3a\
10.0.0.164 itvm25-3a.it.cs.umb.edu itvm25-3a\
10.0.0.165 itvm26-3a.it.cs.umb.edu itvm26-3a\
10.0.0.166 itvm27-3a.it.cs.umb.edu itvm27-3a\
10.0.0.167 itvm28-3a.it.cs.umb.edu itvm28-3a\
 \
10.0.0.168 itvm21-3b.it.cs.umb.edu itvm21-3b\
10.0.0.169 itvm22-3b.it.cs.umb.edu itvm22-3b\
10.0.0.170 itvm23-3b.it.cs.umb.edu itvm23-3b\
10.0.0.171 itvm24-3b.it.cs.umb.edu itvm24-3b\
10.0.0.172 itvm25-3b.it.cs.umb.edu itvm25-3b\
10.0.0.173 itvm26-3b.it.cs.umb.edu itvm26-3b\
10.0.0.174 itvm27-3b.it.cs.umb.edu itvm27-3b\
10.0.0.175 itvm28-3b.it.cs.umb.edu itvm28-3b\
 \
#Addresses for the Windows PCs\
10.0.0.240  it21.it.cs.umb.edu it21\
10.0.0.241  it22.it.cs.umb.edu it22\
10.0.0.242  it23.it.cs.umb.edu it23\
10.0.0.243  it24.it.cs.umb.edu it24\
10.0.0.244  it25.it.cs.umb.edu it25\
10.0.0.245  it26.it.cs.umb.edu it26\
10.0.0.246  it27.it.cs.umb.edu it27\
10.0.0.247  it28.it.cs.umb.edu it28' hosts

log "Hosts file modified successfully"
sleep 2s
log_cat hosts
log "Restarting 'etc/init.d/networking' "
log "-e ${RED} Restart Not Enabled. Please uncomment${NC}"

##RESTARTNIS--------RAW CODE###################################
#/etc/init.d/networking restart
###############################################################

sleep 1s
log "Doing Ping test"
ping -c 4 www.yahoo.com >> $VAR.txt
log "Ping Test Done"
echo "DEBUG: Note to self, do a file check to ensure ping was successful"

################################################
################################################
#Project 3
################################################
################################################

###INSTALL NIS------RAW COMMAND###############################
#sudo apt-get update
#sudo apt-get install nis
#sudo apt-get install sysv-rc-conf
##############################################################

### BEGIN MODIFYING NSSWITCH.CONF ##############

log "NSSWITCH.CONF is changing..."
log_cat nsswitch

sed -i '/passwd:         compat/s/$/ nis/' nsswitch
sed -i '/group:          compat/s/$/ nis/' nsswitch
sed -i '/shadow:         compat/s/$/ nis/' nsswitch
sed -i 's|hosts:          files dns|hosts:          files nis dns |g' nsswitch
sed -i 's|hosts:	  files dns|hosts:	    dns files nis |g' nsswitch
log "NSSWITCH.CONF CHANGED!! "
log_cat nsswitch
log "End of modifying nsswitch.conf "
### END MODIFYING NSSWITCH.CONF ###############

### BEGIN MODIFYING /etc/yp.conf ##############
log "YP.CONF is changing!! "
log_cat yp
sed -i '/com/a\
ypserver 10.0.0.1\' yp
log "YP.CONF has changed"
log_cat yp
### END MODIFYING /etc/yp.conf ########
### RESTART NIS #######################
log "RESTARTING NIS"
log "DEBUG MAKE SURE ITS UNCOMMENTED"

#sudo service ypbind restart
#sudo service sysv-rc-conf ypbind on

### END RESTART NIS ###################
### START NFS INSTALL ################

log "INSTALLING NFS"
#sudo apt-get update
#sudo apt-get install nfs-common
#sudo apt-get install nfs-kernel-server
log "DEBUG: UNCOMMENT THE INSTALL"

log "END OF INSTALLATION OF NFS"
### END NFS INSTALLATION ##############
#######################################
#######################################
log "Project 4"
# PROJECT 4

log "INSTALLING AUTOFS"
#sudo apt-get install autofs
log "MOVING home to home.itvm25-4b"
#sudo mv /home /home.itvm25-4b
log "MAKING NEW HOME"
#sudo mkdir /home
log "DEBUG: UNCOMMENT CODE"

### BEGIN MODYFING /etc/passwd ########

log "MODIFYING passwd"
log_cat passwd 

sed -i 's|sysadmin:x:1000:1000:itvm25-4b,,,:/home/sysadmin:/bin/bash|sysadmin:x:1000:1000:sysadmin,,,:/home.itvm25-4b/sysadmin:/bin/bash|g' passwd
log "passwd has changed to"
log_cat passwd
log "END OF passwd CHANGE"
### END MODIFYING /etc/passwd #########
### MODIFYING EXPORTS #################
log "MODIFYING exports"
log_cat exports
log_append '#input from script' exports
log_append '/home.itvm25-4b 10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)' exports
log "Exports has changed to"
log_cat exports
log "Done modifying exports"
### END MODYFING EXPORTS ##############
### MODIFYING /etc/auto.master ########

log "MODIFYING auto.master"
log "auto.master is changing from this..."
log_cat auto.master
log_append "#input from script" auto.master
log_append "/home /etc/auto.home" auto.master
log "auto.master has changed to this..."
log_cat auto.master
log "DONE MODIFYING auto.master"
### END MODIFYING /etc/auto.master#####


### PROJECT 5 ####


