#! /bin/bash

cpu_cores=`dmidecode -t 4 | grep 'Core Count' | awk '{print $3}'`
cc () { echo "CPU CORES COUNT: $cpu_cores"; }

disk_size=`df -H | grep 'dev' | awk 'NR==1 {print $2}'`
ds () { echo "DISK SIZE: $disk_size"; }

memory=`free -g | awk 'NR==2 {print $2}'`
ram () { echo "RAM MEMORY SIZE: "$memory"G"; }

last_users=`last -10 | grep -v 'reboot' | awk 'NR<6 {print $1, $4, $5, $6, $7, $8, $9, $10}'`
logins () { echo "LAST LOGINS:";echo;echo "$last_users"; }

active_py_perl_ps=`ps -ef | grep -c 'python\|perl'`
pp () { echo "Number of active Python and Perl Proccesses: ""$(($active_py_perl_ps-1))"; }

Help () {
	echo;echo "'cc' to show CPU CORES COUNT";echo
	echo "'ds' to show DISK SIZE";echo
	echo "'ram' to show RAM MEMORY SIZE";echo
	echo "'logins' to show LAST LOGINST";echo
	echo "'pp' to show Number of active Python and Perl Proccesses";echo
}

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

if [ -z "$1" ]
then
	echo
	echo 'CPU CORES COUNT: '$cpu_cores
	echo
	echo 'DISK SIZE: '$disk_size
	echo
	echo 'RAM MEMORY SIZE: '$memory'G'
	echo
	echo 'LAST LOGINS:'
	echo
	echo "$last_users" 
	echo
	echo 'Number of active Python and Perl Proccesses: '"$(($active_py_perl_ps-1))"
	echo

else
	$1
fi		
