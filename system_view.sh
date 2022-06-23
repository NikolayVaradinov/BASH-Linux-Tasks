#! /bin/bash

cc () { echo -n "CPU CORES COUNT: "
	dmidecode -t 4 | grep 'Core Count' | awk '{print $3}'
}

ds () { echo -n "DISK SIZE: "
	df -H | grep 'dev' | awk 'NR==1 {print $2}'
}

ram () { echo -n "RAM MEMORY SIZE: "
	free -g | awk 'NR==2 {print $2}''G'
}

logins () { echo "LAST LOGINS:";echo
	last -10 | grep -v 'reboot' | awk 'NR<6 {print $1, $4, $5, $6, $7, $8, $9, $10}';echo
}

pp () 
{ 
	echo -n "Number of active Python and Perl Proccesses: "
	ps -ef | grep -c 'python\|perl' | expr "$(cat)" - 1
}

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

$1		
