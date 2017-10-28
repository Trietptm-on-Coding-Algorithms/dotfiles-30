#!/bin/bash
#script that lists apps currently using the network
#black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
#magenta=`tput setaf 5`
cyan=`tput setaf 6`
red=`tput setaf 1`
norm=`tput sgr0`

bold=`tput bold`
#ulbegin=`tput smul`
#ulend=`tput rmul`

ser="$cyan"
name="$bold$cyan"
tput setaf 6
echo ' Programmes currently using the network ' 
tput setaf 1
lsof -nPi | awk '/.*python[2]*/ || /.*java/ {cmd[$2] = $2;next}
                 !/COMMAND/ {cmd[$1]=$1}
                 END {for (item in cmd ) {
                          sub(".*/", "", item)
                         print item}
                     }'

