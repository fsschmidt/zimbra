#!/bin/bash
#Source: https://wiki.zimbra.com/wiki/Clearing_the_%22don%27t_inherit_grants_from_parent_folder%22(i)_flag
 
 account=$1
 
 if [ x"$(id -n -u)" != x"zimbra" ]
 then
 	echo "Ce script doit etre lance sous l'utilisateur zimbra"
 	exit 1
 fi
 
 zmprov ga "$1" &> /dev/null
 
 if [ $? -ne 0 ]
 then
 	echo "Le compte $account n'existe pas !"
 	exit 1
 fi
 
 zmmailbox -z -m "$account" gaf | sed "1,2d" | cut -d "/" -f "2-" | while read folder
 do
 	echo "On traite le dossier '/$folder'"
 	oldflags=$(zmmailbox -z -m "$account" gf "/$folder" | grep flags | head -n 1 | cut -d ":" -f 2 | sed 's@[^"]*"\([^"]*\)".*@\1@')
 	echo " ** old flags : '$oldflags'"
 	newflags=$(echo "$oldflags" | sed 's@i@@g')
 	echo " ** new flags : '$newflags'"
 
 	if [ x"$oldflags" != x"$newflags" ]
 	then
 		echo "=> On essaye d'appliquer les nouveaux flags"
 		zmmailbox -z -m "$account" mff "/$folder" "$newflags"
 		if [ $? -eq 0 ]
 		then
 			echo "** Nouveaux flags appliques avec succes"
 		else
 			echo "** Nouveau flags non appliques"
 		fi
 	else
 		echo "=> Rien a faire"
 	fi
 	echo "<-------------------------------------------->"
 done;
