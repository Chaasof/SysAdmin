#!/bin/bash


function taskAdmin(){
echo -e " Comment voulez vous executer la tâche?:
 (Chaque: [H]eure,[J]our,[S]emaine,[M]ois,[P]ersonnalisé)"

read exe

case $exe in
	'h'|'H') echo -e "Enrez la commande:"
	read cmd
	echo $cmd >> /etc/cron.hourly/syshourly;;
		

	'j'|'J')echo -e "Entez la commande:"
	read cmd
	echo $cmd >> /etc/cron.daily/sysdaily;;
	

	's'|'S') echo -e "Entez la commande:"
	echo -n "cmd: "
	echo $cmd >> /etc/cron.weekly/sysweekly;;
	

	'm'|'M')echo -e "Entez la commande:"
	read cmd
	echo $cmd >> /etc/cron.monthly/sysmonthly;;
	
	
	'p'|'P') echo -e "Entrez la commande:"
	read $cmd
	
	echo -n "Minutes [0-59]: "
	read min
	until [[ $min -lt 60 && $min -ge 0 || "x"$min == 'x' ]] 
	do
		echo -n "Minutes [0-59]: "
		read min
	done
		if [ -z $min ]
		then
			min="\x2a"
		fi

	echo -n "Heure [0-23]: "
	read hr	
	until [[ $hr -lt 24 && $hr -ge 0 || "x"$hr == 'x' ]] 
	do
		echo -n "Heure [0-23]: "
		read hr
	done
		if [ -z $hr ]
		then
			hr="\x2a"
		fi

	echo -n "Jour [1-31]: "
	read dom
	until [[ $dom -lt 32 && $dom -ge 0 || "x"$dom == 'x' ]] 
	do
		echo -n "Jour [1-31]: "
		read dom
	done
		if [ -z $dom ]
		then
			dom="\x2a"
		fi

	echo -n "Mois [1-12]: "
	read month
	until [[ $month -lt 13 && $month -gt 0 || "x"$month == 'x' ]] 
	do
		echo -n "Mois [1-12]: "
		read month
	done
		if [ -z $month ]
		then
			month="\x2a"
		fi

	echo -n "Jour de la semaine [1-7]: "
	read dow
	until [[ $dow -lt 8 && $dow -gt 0 || "x"$dow == 'x' ]] 
	do
		echo -n "Jour de la semaine[1-7]: "
		read dow
	done
		if [ -z $dow ]
		then
			dow="\x2a"
		fi
	echo -e "writing : $min $hr $dom $month $dow $cmd >> /etc/crontab";;
	


	esac

}

function taskUser(){

echo "Entrez le nom d'utilisateur:"
read username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
 echo -e "Entrez la commande:"
 read $cmd
echo -n "Minutes [0-59]: "
	read min
	until [[ $min -lt 60 && $min -ge 0 || "x"$min == 'x' ]] 
	do
		echo -n "Minutes [0-59]: "
		read min
	done
		if [ -z $min ]
		then
			min="\x2a"
		fi

	echo -n "Heure[0-23]: "
	read hr	
	until [[ $hr -lt 24 && $hr -ge 0 || "x"$hr == 'x' ]] 
	do
		echo -n "Heure [0-23]: "
		read hr
	done
		if [ -z $hr ]
		then
			hr="\x2a"
		fi

	echo -n "Jour [1-31]: "
	read dom
	until [[ $dom -lt 32 && $dom -ge 0 || "x"$dom == 'x' ]] 
	do
		echo -n "Jour[1-31]: "
		read dom
	done
		if [ -z $dom ]
		then
			dom="\x2a"
		fi

	echo -n "Mois [1-12]: "
	read month
	until [[ $month -lt 13 && $month -gt 0 || "x"$month == 'x' ]] 
	do
		echo -n "Mois [1-12]: "
		read month
	done
		if [ -z $month ]
		then
			month="\x2a"
		fi

	echo -n "Jour de la semaine [1-7]: "
	read dow
	until [[ $dow -lt 8 && $dow -gt 0 || "x"$dow == 'x' ]] 
	do
		echo -n "Jour de la semaine [1-7]: "
		read dow
	done
		if [ -z $dow ]
		then
			dow="\x2a"
		fi

	echo $min $hr $dom $month $dow $cmd >> /var/spool/cron/$username


 else
echo "Cet utilisateur n'existe pas"
fi

}

function taskAT(){

echo "Entrez l'heure et le jour  ou la tâche devra être exécutée"
echo -n "Heure:"
read hour
echo -n "Jour:"
read day
at $hour
}

function listTask(){
echo "Entrez le nom d'utilisateur:"
 read username
egrep "^$username" /etc/passwd >/dev/null
   if [ $? -eq 0 ]; then
  
crontab  -u $username  

  else
  echo "Cet utilisateur n'existe pas"
   fi

}

function deleteTask(){

 echo "Entrez le nom d'utilisateur:"
  read username
 egrep "^$username" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then 
 crontab -u $username -e
 
   else
   echo "Cet utilisateur n'existe pas"
    fi

}


echo "                       "
echo "*******Gestion Des Tâches Planifiées************"
echo "** 1 - Planifier une tâche Administrateur     **"
echo "** 2 - Planifier une tâche Simple utilisateur **"
echo "** 3 - Planifier une tâche AT                 **"
echo "** 4 - Lister les tâches planifiées           **"
echo "** 5 - Supprimer une tâche                    **"
echo "** 6 - Retour                                 **"
echo "** 7 - Sortir                                 **"
echo "************************************************"

echo "                               "
echo -n "Votre choix:"
read choix
case $choix in
1)taskAdmin
./cronmanage.sh;;
2)taskUser
./cronmanage.sh;;
3)taskAT
./cronmanage.sh;;
4)listTask
./cronmanage.sh;;
5)deleteTask
./cronmanage.sh;;
6)./main.sh;;
7) exit 0;;
esac



