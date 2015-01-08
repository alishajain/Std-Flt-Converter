#!/bin/bash
 
# Declare variable choice and assign value 4
choice=3
# Print to stdout
 echo "1. Stad-flt"
 echo "2. Flt-Stad"
 echo -n "Please choose a word [1,2]? "
# Loop while the variable choice is equal 4
# bash while loop
while [ $choice -eq 3 ]; do
 
# read user input
read choice
# bash nested if/else
if [ $choice -eq 1 ] ; then
 
	echo `./std-flt.sh`
	echo "*****************************************************************"
	echo "*	Run the following command to convert the file		*"
	echo "*	./flt-std input_file_name.flt output_file_name.std	*"
	echo "*****************************************************************"


else                   

        if [ $choice -eq 2 ] ; then
		echo `./flt-std.sh`
		echo "*****************************************************************"
		echo "*	Run the following command to convert the file		*"
		echo "*	./flt-std input_file_name.flt output_file_name.std	*"
		echo "*****************************************************************"

                else
                        echo "Please make a choice between 1-2 !"
			echo "1. Stad-flt"
			echo "2. Flt-Stad"
                        echo -n "Please choose a word [1,2]? "
                         choice=3
                fi   
        fi
done 
