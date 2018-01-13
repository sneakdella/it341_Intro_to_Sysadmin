#!/bin/bash
[ "$UID" -eq 0 ] || { echo "This script must be run as root. Please type 'sudo' first then the path to the script."; exit 1;}

echo "Authentication, successful!"




NC='\033[0m' # No Color
RED='\033[0;31m'

#set the logfile name here
VAR=scriptlog

#Echos a new line
new_line() {
echo '---------------------------------------------'
}

#Creates lines for neatness and puts $1 into log file and displays
# on normal output
log() {
	new_line | tee -a $VAR.txt
	echo $1 | tee -a $VAR.txt
	new_line | tee -a $VAR.txt
}

# Does the same as log() but it is for cat
log_cat() {
	new_line | tee -a $VAR.txt
	cat $1 | tee -a $VAR.txt
	new_line | tee -a $VAR.txt
}

# Same as log() but for "echo text >> into_this_file.txt"
log_append() {
	echo $1 >> $2 | tee -a $VAR.txt
}
#########################################
log "BEGIN INSTALL"
log "MODIFYING HOSTS FILE"
#########################################
#BEGIN MODIFYING HOSTFILE
#########################################
sed -i '$ a # Gateway' /etc/hosts
sed -i '$ a 10.0.0.1' /etc/hosts
sed -i '$ a # Virtual Machines' /etc/hosts
for i in {1..8}
do
        a='-3a'
        sed -i "$ a ex itvm2$i$a.it.cs.umb.edu itvm2$i$a" /etc/hosts
done

for i in {1..8}
do
        b='-3b'
        sed -i "$ a ex itvm2$i$b.it.cs.umb.edu itvm2$i$b" /etc/hosts
done

for i in {160..175}
do
        sed -i "0,/ex/s/ex/10.0.0.$i/" /etc/hosts
done

sed -i "$ a # Windows Hosts hosts" /etc/hosts
for i in {21..28}
do
        sed -i "$ a xe it$i.it.cs.umb.edu it$i" /etc/hosts
done

for i in {240..247}
do
        sed -i "0,/xe/s/xe/10.0.0.$i/" /etc/hosts
done
#########################################
#########################################

log "Hosts file modified successfully"
sleep 2s
log_cat /etc/hosts
log "Restarting 'etc/init.d/networking' "
#BELOW WAS A DEBUG, KEEP COMMENTED. RESTART IS WORKING FINE.
#log "-e ${RED} Restart Not Enabled. Please uncomment${NC}"

##RESTARTNIS--------RAW CODE###################################
/etc/init.d/networking restart
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
sudo apt-get update
sudo apt-get install nis
sudo apt-get install sysv-rc-conf
##############################################################

### BEGIN MODIFYING NSSWITCH.CONF ##############
NS=/etc/nsswitch.conf

log "NSSWITCH.CONF is changing..."
log_cat $NS

sed -i '/passwd:         compat/s/$/ nis/' $NS
sed -i '/group:          compat/s/$/ nis/' $NS
sed -i '/shadow:         compat/s/$/ nis/' $NS
sed -i 's|hosts:          files dns|hosts:          files nis dns |g' $NS
sed -i 's|hosts:	  files dns|hosts:	    dns files nis |g' $NS
log "NSSWITCH.CONF CHANGED!! "
log_cat $NS
log "End of modifying nsswitch.conf "
### END MODIFYING NSSWITCH.CONF ###############

### BEGIN MODIFYING /etc/yp.conf ##############
YP=/etc/yp.conf

log "YP.CONF is changing!! "
log_cat $YP
sed -i '/com/a\
ypserver 10.0.0.1\' $YP
log "YP.CONF has changed"
log_cat $YP
### END MODIFYING /etc/yp.conf ########
### RESTART NIS #######################
log "RESTARTING NIS"
log "DEBUG MAKE SURE ITS UNCOMMENTED"
##### SERVICE RESTART --- COMMAND ##########
sudo service ypbind restart
sudo service sysv-rc-conf ypbind on
############################################

### END RESTART NIS ###################
### START NFS INSTALL ################

log "INSTALLING NFS"
### NFS INSTALL #############################
sudo apt-get install nfs-common
sudo apt-get install nfs-kernel-server
#############################################
log "DEBUG: UNCOMMENT THE INSTALL"

log "END OF INSTALLATION OF NFS"
### END NFS INSTALLATION ##############
#######################################
#######################################
log "Project 4"
# PROJECT 4
###### INSTALL AUTOFS------ COMMAND##########
log "INSTALLING AUTOFS"
sudo apt-get install autofs
#############################################

###### MV HOME -------------- COMMAND########
log "MOVING home to home.itvm25-4b"
sudo mv /home /home.itvm25-4b
#############################################

###### MKDIR ---------------- COMMAND #######
log "MAKING NEW HOME"
sudo mkdir /home
#############################################
#log "DEBUG: UNCOMMENT CODE"
### BEGIN MODYFING /etc/passwd ########
PD=/etc/passwd
log "MODIFYING passwd"
log_cat $PD 

sed -i 's|sysadmin:x:1000:1000:itvm25-4b,,,:/home/sysadmin:/bin/bash|sysadmin:x:1000:1000:sysadmin,,,:/home.itvm25-4b/sysadmin:/bin/bash|g' $PD
log "passwd has changed to"
log_cat $PD
log "END OF passwd CHANGE"
### END MODIFYING /etc/passwd #########
### MODIFYING EXPORTS #################
EP=/etc/exports
log "MODIFYING exports"
log_cat $EP
log_append '#input from script' $EP
log_append '/home.itvm25-4b 10.0.0.0/24(rw,sync,no_root_squash,no_subtree_check)' $EP
log "Exports has changed to"
log_cat $EP
log "Done modifying exports"
### END MODYFING EXPORTS ##############
### MODIFYING /etc/auto.master ########
AM=/etc/auto.master
log "MODIFYING auto.master"
log "auto.master is changing from this..."
log_cat $AM
log_append "#input from script" $AM
log_append "/home /etc/auto.home" $AM
log "auto.master has changed to this..."
log_cat $AM
log "DONE MODIFYING auto.master"
### END MODIFYING /etc/auto.master#####
