#!/bin/bash

#Finds and replaces dhcp with static
sed -i 's/dhcp/static/g' interfaces

#Adds network, gateway, broadcast, netmask and dns-nameservers
#after the line that contains 'static'
sed -i '/static/a\ \
    network 10.0.0.0\
    gateway 10.0.0.1\
    broadcast 10.0.0.255\
    netmask 255.255.255.0\
    dns-nameservers 10.0.0.1' interfaces
