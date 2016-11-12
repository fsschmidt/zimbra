#!/bin/bash

# create a variable to hold the input
read -p "Please enter something: " userInput

# Check if string is empty using -z. For more 'help test'    
if [[ -z "$userInput" ]]; then
   printf '%s\n' "No input entered"
      exit 1
	  else
	     # If userInput is not empty show what the user typed in and run ls -l
		    printf "You entered %s " "$userInput"
			   fi
