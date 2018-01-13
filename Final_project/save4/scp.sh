#!/bin/bash
ITVM="10.0.0.80"
echo $ITVM
scp sysadmin@$ITVM:/home/sysadmin/test1/* .
scp sysadmin@$ITVM:/home/sysadmin/test1/original_files/* .
