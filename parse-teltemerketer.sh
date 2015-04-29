#!/bin/bash
#
#   MTPN2CSVcard
#   by xanda
#   https://github.com/xanda/MTPN2CSVcard
#
#   version: 0.1
#   release date: 29 April 2015
#
#   WTFPL - Do What The Fuck You Want To Public License
#   ===================================================
#   This program is free software. It comes without any warranty, to
#   the extent permitted by applicable law. You can redistribute it
#   and/or modify it under the terms of the Do What The Fuck You Want
#   To Public License, Version 2, as published by Sam Hocevar. See
#   http://sam.zoy.org/wtfpl/COPYING for more details.

if [ "$#" -eq 2 ]; then
   if [ "$1" == "csv" ]; then
	   teledata=`curl -A MSIE http://christopherteh.com/blog/2011/10/telemarketer/ | grep -B 100000000 'and I will add them here, crediting you if you wish' | grep -E '^[+0-9\-]+' | sed -r 's/(Added|Contributed|Corrected|Updated|<br\ \/>).*$//g' |  sed -r 's/\;/./g' | sed 's/&#8211./-/g' | sed 's/&#038./\&/g'`
	   telePrefix=$2  
	   echo "First Name,Middle Name,Last Name,Title,Suffix,Initials,Web Page,Gender,Birthday,Anniversary,Location,Language,Internet Free Busy,Notes,E-mail Address,E-mail 2 Address,E-mail 3 Address,Primary Phone,Home Phone,Home Phone 2,Mobile Phone,Pager,Home Fax,Home Address,Home Street,Home Street 2,Home Street 3,Home Address PO Box,Home City,Home State,Home Postal Code,Home Country,Spouse,Children,Manager's Name,Assistant's Name,Referred By,Company Main Phone,Business Phone,Business Phone 2,Business Fax,Assistant's Phone,Company,Job Title,Department,Office Location,Organizational ID Number,Profession,Account,Business Address,Business Street,Business Street 2,Business Street 3,Business Address PO Box,Business City,Business State,Business Postal Code,Business Country,Other Phone,Other Fax,Other Address,Other Street,Other Street 2,Other Street 3,Other Address PO Box,Other City,Other State,Other Postal Code,Other Country,Callback,Car Phone,ISDN,Radio Phone,TTY/TDD Phone,Telex,User 1,User 2,User 3,User 4,Keywords,Mileage,Hobby,Billing Information,Directory Server,Sensitivity,Priority,Private,Categories"
	   echo "$teledata" | while read line;
	   do
		  IFS=' ' read -a array <<< "$line"
		  phoneNum=${array[0]}
		  array[1]=`echo ${array[1]} | sed -r 's/^\(//g'`
		  teleName=""
		  for (( i=1 ; i < ${#array[@]}; i++ )); do
			 teleName=$teleName" "${array[$i]}
		  done
		  teleName=$telePrefix" - "$teleName
		#Output format:
		#First Name,Middle Name,Last Name,Title,Suffix,Initials,Web Page,Gender,Birthday,Anniversary,Location,Language,Internet Free Busy,Notes,E-mail Address,E-mail 2 Address,E-mail 3 Address,Primary Phone,Home Phone,Home Phone 2,Mobile Phone,Pager,Home Fax,Home Address,Home Street,Home Street 2,Home Street 3,Home Address PO Box,Home City,Home State,Home Postal Code,Home Country,Spouse,Children,Manager's Name,Assistant's Name,Referred By,Company Main Phone,Business Phone,Business Phone 2,Business Fax,Assistant's Phone,Company,Job Title,Department,Office Location,Organizational ID Number,Profession,Account,Business Address,Business Street,Business Street 2,Business Street 3,Business Address PO Box,Business City,Business State,Business Postal Code,Business Country,Other Phone,Other Fax,Other Address,Other Street,Other Street 2,Other Street 3,Other Address PO Box,Other City,Other State,Other Postal Code,Other Country,Callback,Car Phone,ISDN,Radio Phone,TTY/TDD Phone,Telex,User 1,User 2,User 3,User 4,Keywords,Mileage,Hobby,Billing Information,Directory Server,Sensitivity,Priority,Private,Categories
		  echo $teleName",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"$phoneNum",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Normal,,TELEMARKETER"
	   done
    elif [ "$1" == "vcf" ]; then
	   teledata=`curl -A MSIE http://christopherteh.com/blog/2011/10/telemarketer/ | grep -B 100000000 'and I will add them here, crediting you if you wish' | grep -E '^[+0-9\-]+' | sed -r 's/(Added|Contributed|Corrected|Updated|<br\ \/>).*$//g' |  sed -r 's/\;/./g' | sed 's/&#8211./-/g' | sed 's/&#038./\&/g'`
	   telePrefix=$2  
	   echo "$teledata" | while read line;
	   do
		  IFS=' ' read -a array <<< "$line"
		  phoneNum=${array[0]}
		  array[1]=`echo ${array[1]} | sed -r 's/^\(//g'`
		  teleName=""
		  for (( i=1 ; i < ${#array[@]}; i++ )); do
			 teleName=$teleName" "${array[$i]}
		  done
		  teleName=$telePrefix" - "$teleName
		#Output format:
			#BEGIN:VCARD
			#VERSION:3.0
			#FN:NAME
			#N:;NAME;;;
			#TEL;TYPE=WORK:1234567890
			#END:VCARD
  		  echo "BEGIN:VCARD"
		  echo "VERSION:3.0"
		  echo "FN:"$teleName
		  echo "N:;"$teleName";;;"
		  echo "TEL;TYPE=WORK:"$phoneNum
		  echo "END:VCARD"
	   done
	else
	   echo "Invalid format argument."
	   echo "Supported format: csv, vcf"
    fi
else
    echo "------------------------------------------------------------------------------"
	echo "MTPN2CSV - Malaysia telemarketer phone numbers to (Outlook contact format) CSV"
	echo "by @xanda (Adnan bin Mohd Shukor)"
    echo ""
    echo "Credit to 'Malaysia telemarketer phone numbers: List of numbers to block and avoid'"
	echo "          ( http://christopherteh.com/blog/2011/10/telemarketer/ )"
    echo "Espacially Christopher Teh Boon Sung and all controbutors"
	echo "------------------------------------------------------------------------------"
	echo ""
    echo "Usage: ./parse-teltemerketer.sh [FORMAT csv, vcf] [PREFIX NAME]"
    echo "Usage: Satisfy with the output? Create the file by piping the output to a file:"
	echo "       Example 1: ./parse-teltemerketer.sh csv TELEMARKETER > /home/me/contacts.csv"
	echo "       Example 2: ./parse-teltemerketer.sh vcf ALERT > /home/me/contact.vcf"
	echo ""
	echo "I highly encourage to put a prefix for the name to clearly create the alert when they call us. So I've make it conpulsary to enter the prefix"
	echo ""
	echo "Example 1: ./parse-teltemerketer.sh csv TELEMARKETER"
	echo "Output 1 : TELEMARKETTER - Maxis. Aggressive spammers),,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,26363,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Normal,,TELEMARKETER"
	echo ""
	echo "Example 2: ./parse-teltemerketer.sh vcf ALERT"
	echo "Output 2 : BEGIN:VCARD"
    echo "           VERSION:3.0"
    echo "           FN:TELEMARKETER - Maxis. Aggressive spammers)"
    echo "           N:;TELEMARKETER - Maxis. Aggressive spammers);;;"
    echo "           TEL;TYPE=WORK:26363"
    echo "           END:VCARD"
fi
