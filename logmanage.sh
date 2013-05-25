#! /bin/bash
function rechercheLog(){
	while true
	do
		echo "Les logs de quel utilisateur ?"
		read user
	    	if [ -z "$user" ]
    		then
			echo "Vous devez entez un nom d'utilisateur"
    		elif [ -z "$(grep $user /etc/passwd)" ]
    		then
			echo "Cet utilisateur n'existe pas"

    		else
			break
		fi
	done

echo "[1] mail"
echo "[2] boot"
echo "[3] "
echo "[4] "
read choixServ
   case $choixServ in 
	0) file="/var/log/maillog";;
	1) file="/var/log/boot.log";;
	*) echo "Merci de choisir un service figurant dans la liste";;

  esac

echo "[0] Emerg (emergency)       ⇒ Système inutilisable"
echo "[1] Alert                   ⇒ Une intervention immédiate est nécessaire"
echo "[2] Crit (critical)         ⇒ Erreur critique pour le système"
echo "[3] Err (error)             ⇒ Erreur de fonctionnement"
echo "[4] Warning                 ⇒ Avertissement"
echo "[5] Notice                  ⇒ Événement normal méritant d'être signalé"
echo "[6] Info (informational)    ⇒ pour information seulement"
echo "[7] Debug                   ⇒ Message de mise au point"

echo -n "Choissiez une priorité"
read choixPrio
  case $choixPrio in
    	0) prio="emerg";;
    	1) prio="alert";;
	2) prio="crit";;
	3) prio="err";;
	4) prio="warning";;
	5) prio="notice";;
	6) prio="info";;
	7) prio="debug";;
	*) echo "merci de choisir un priorité figurante dans la liste";; 
  esac
}

function logrotateConf(){

echo "vous voulez editer la fréquence des rotations de log ? [O/N]"
read yn
case yn in
	[oO]) echo "[D] Daily"
	      echo "[W] Weekly"
	      echo "[M] Monthly"
	      read sentence
		 
		case sentence in
			[Dd]) var="daily";;
			[Ww]) var="weekly";;
			[Mm]) var="monthly";;
		esac ;
		oldVar=`grep -i '^[d;w;m]' /etc/logrotate.conf`;
		sed -n -i "$oldVar/c$var" /etc/logrotate.conf;
		echo "la rotation des log est changé pour être $var"
	;;
	[nN]) ;;
esac

}
function sys(){
 echo "les lignes commençant par # sont des commentaires"
     echo "[sevice.priorité] ========== fichier de direction"
     echo "Liste des services : Emerg (emergency)       ⇒ Système inutilisable"
     echo "                     Alert                   ⇒ Une intervention immédiate est nécessaire"
     echo "                     Crit (critical)         ⇒ Erreur critique pour le système"
     echo "                     Err (error)             ⇒ Erreur de fonctionnement"
     echo "                     Warning                 ⇒ Avertissement"
     echo "                     Notice                  ⇒ Événement normal méritant d'être signalé"
     echo "                     Info (informational)    ⇒ pour information seulement"
     echo "                     Debug                   ⇒ Message de mise au point"

     echo "Liste des priorités: emerg | alert | crit | err | warning | notice | info | debug"
     echo "vous souhaitez le modifier ? [O/N]"
     read tt
	case tt in
	   [Oo]) vim /etc/syslog.conf;;
	   [Nn]) ./logmanage.sh;;
	esac
}

clear;
echo "          "
echo "**************************************************"
echo "** 1 - Editer le fichier syslog.conf            **"
echo "** 2 - Rechercher un log                        **"
echo "** 3 - Editer logrotate                         **"
echo "** 4 - Retour                                   **" 
echo "** 5 - Sortir                                   **"
echo "**************************************************"
echo "         "
echo "Quel est votre choix :"
read choix

case $choix in
  1)sys;;
  2) echo "Recherche ..."
    rechercheLog;;
  3) logrotateConf 
	vim /etc/logrotate.conf
	./logmanage.sh;;
  4) ./main.sh;;
  5) exit 0;;
  *) echo "choix n'existe pas";;
esac
