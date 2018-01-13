#!/bin/bash

clear

menu_ec(){
echo "********************************"
echo "****** CODE BY JACOB YUHAS *****"
echo "**** jacob.yuhas001@umb.edu ****"
echo "********************************"
echo "--------------------------------"
echo "------------MENU----------------"
echo "Press 1 To Create a New Log File"
echo "Press 2 To Enter Into An Existing Log File"
echo "Press 3 To Clear"
echo "Press 4 To Quit"
echo "////////////////////////////////////////"
echo " "
}

clear_window(){
	clear
}

#NOTES: Program Working As Intended (almost) - need to loop 2

x=0

#COLORS
RED='\033[0;31m'
NONE='\033[00m'

current_date(){
	date +"%D"
}

exist_check(){
	echo $project_number

	file="project_"$project_number".txt"
	if [ -f "$file" ]
	then
		echo "$file found!"
		cat $file
	else
		echo -e "${RED} ERROR: "project_"$project_number".txt"  not found."
		echo -e "${RED} ERROR: $file not found."
		echo -e "${RED} Exiting Script. Please Create The File First"
		echo -e "${NONE} Exiting..."
		exit
	fi
}

exist_overwrite_protection(){

	file_two="project_"$new_project_number.txt


	if [ -f "$file_two" ]
	then
		echo -e "${RED} WARNING: File found. Exiting Script to ensure overwrite does not happen."
		echo -e "${NONE} Exiting Script..."
		echo " "
		cat $file_two
		exit
	else
		echo "File not found. Creating file."
	fi

}

create_projectlog(){
echo " "
echo "Please enter the project number (1 Digit): "
read new_project_number

exist_overwrite_protection
echo " "
echo "Please enter the project name: "
read new_project_name
echo " "
echo "Please enter your name" 
read users_name

echo " "
echo Creating file $new_project_name
echo " " > "project_"$new_project_number.txt
echo "| "$users_name "| "$(current_date) "| project_"$new_project_number "Admin Log |" $new_project_name "|" >> "project_"$new_project_number.txt
echo "---------------------------------------------------------------" >> "project_"$new_project_number.txt


echo "Finished! Running cat on project_"$new_project_number".txt"
echo " "
cat "project_"$new_project_number.txt
echo "+ Your first entry will appear here. This is an example provided by the program. This line is not part of the file."
echo " "
}


ammend_projectlog(){

echo "Please enter the project number (1 Digit): "
read project_number

exist_check

echo "Enter the information you wish to log."
read log_entry

echo Inserting Entry To "project_"$project_number.txt
echo "+ "$log_entry >> "project_"$project_number.txt
echo Ammended "project_"$project_number.txt
cat "project_"$project_number.txt

}


run_main_prog(){
	echo " "
	read USERINPUT
	if [ "$USERINPUT" = "1" ]
	then
		create_projectlog
	elif [ "$USERINPUT" = "2" ]
	then
		ammend_projectlog
	elif [ "$USERINPUT" = "3" ]
	then
		clear_window
	elif [ "$USERINPUT" = "4" ]
	then
		x=1
	else
		echo Not valid
		exit
	fi
}

while [ $x = 0 ]
do
	menu_ec
	run_main_prog
done
exit $?
