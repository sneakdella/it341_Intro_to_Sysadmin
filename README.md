# it341_Intro_to_Sysadmin
These are scripts that I saved from my Linux shell while taking the IT341 course (Intro to Sys Admin) course at Umass Boston

The first two assignments listed are working with the Linux tool "sed"


############## FINAL PROJECT FOLDER, VERY IMPORTANT##################################################################################
The final project uses "sed" extensively to almost fully automate an installation of a Ubuntu Server. It will modify the following files:
- hosts
- NSSWITCH.conf
- /etc/yp.conf
- /etc/passwd
- /etc/exports
- /etc/auto.master

The final script will also install the following:
- nis
- sys-rc-conf
- nfs
- nfs-kernel-server
- autofs

The final script will also restart the following services when it reaches to said step (after modifying files):
- /etc/init.d/networking (restarts the networking daemon)
- ybind (nis)
- "sudo service sysv-rc-conf ypbind on" (turns it back on)

This script will also perform a ping test after restarting the networking daemon. However, it will NOT stop the script and continue if the ping test fails. This was added in by myself and not a requirement.

Finally, the most important part is this script will ALSO output everything into a log file. I wrote a function in the beginning called "log()" and called on it extensively in the script. If you look in earlier versions of the saves you will see that the script is almost twice as large because I wanted it to output to the shell and also echo text into the script.

You may also see the function "log cat()" -- this function does the same as "log()" but instead will run "cat" (instead of echo) on a file and output the contents of the file to normal output (the shell) and append it to the log file. 

"Log append()" will do the same as log() except append to the logfile the operator designates with the variable "VAR"

The variables NC and RED are just for text coloring. I used this while debugging.

At the beginning of the script I put in a special command that took me hours to research and it was to force the Linux operator to run the script as SUDO. Otherwise, the script would not work when modifying files in the /etc/ and other directories under root.

Sadly this script will not automate the initilal installation of an Ubuntu or any Linux distro. This is meant to be ran post-barebone install.
