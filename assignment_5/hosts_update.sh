#!/bin/bash

#Finds the line with 'localhost' and adds the Gateway and Windows
#PCs to the hosts file

sed -i '/localhost/a\ \
#Gateway\
10.0.0.1 it20.it.cs.umb.edu it20\
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
