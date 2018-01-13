#!/bin/bash

#edits the hosts file in current directory
NC='\033[0m' # No Color
RED='\033[0;31m'
VAR=scriptlog

new_line() {
echo ' ' >> $VAR.txt
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

echo "Hosts file modified successfully" >> $VAR.txt
echo "Hosts file modified successfully"
new_line
sleep 2s
cat hosts
new_line
echo "Restarting 'etc/init.d/networking' " >> $VAR.txt
echo "Restarting 'etc/init.d/networking' "
new_line
echo -e "${RED} Restart Not Enabled. Please uncomment${NC}" >> $VAR.txt
echo -e "${RED} Restart Not Enabled. Please uncomment${NC}"
new_line
# /etc/init.d/networking restart
sleep 1s
new_line
echo "Doing Ping test" >> $VAR.txt
echo "Doing Ping test"
new_line
ping -c 4 www.yahoo.com >> $VAR.txt
new_line
echo "Ping Test Done" >> $VAR.txt
echo "Ping Test Done, check scriptlog"
new_line
echo "DEBUG: Note to self, do a file check to ensure ping was successful"
