#!/bin/bash

function listCart(){
	ifconfig -a | sed -n -e 1,2p> listeCarte
	cat listeCarte

}

function configureCart(){
	echo " Entrez le nom de l'interface :"
	read int
	echo " Entrez l'adresse IP de la carte "
	read ip
	echo " Entrez le mask :"
	read mask
	ifconfig $int $ip netmask $mask
  
}
function upDownCart(){
	ifs=(`ifconfig | grep -i link | awk '{print $1}'`)
  	compt=0
  	for i in "${ifs[@]}"
  	do
		echo "<$compt> $i"""
    		let compt++
  	done
	
	echo "Choisir le numéro de la carte : "
  	read choix
  
  	echo "<1> pour activer la carte"
  	echo "<2> pour désactiver la carte"
  	echo "Que voulez vous faire ?"
  	read choix2

  	case $choix2 in
    		1) cmd="up";;
    		2) cmd="down";;
  	esac

	ifconfig ${ifs[$choix]} $cmd

}

function changeDNS(){
  	echo "Donner la nouvelle addresse du serveur de noms: "
  	read address
  	sed -i "/nameserver /cnameserver $address" /etc/resolv.conf
  	echo "nameserver $address"
	notify-send 'opération réussite'
}

function changeMachineName(){
   	#manipulation de l'utilisateur
	echo "Entrez un nouveau nom pour la machine:"  
 	echo -n "Nom de la machine: "
	read hostname
	
	#affectation du nom nouveau nom
	sed -i "/HOSTNAME/cHOSTNAME=$hostname" /etc/sysconfig/network
	hostname $hostname
	notify-send 'opération réussite'

}

function restartService(){

	service network restart
}


  echo "             "
   echo "***************Gestion réseau*********************"
   echo "** 1 - Lister les cartes réseaux                **"
   echo "** 2 - Changer la configuration IP d'une carte  **"
   echo "** 3 - Activer/Désactiver une carte             **"
   echo "** 4 - Changer de serveur de noms               **"
   echo "** 5 - Changer le nom de la machine             **"
   echo "** 6 - Redemrrer le service réseau              **"
   echo "** 7 - Retour                                   **"
   echo "** 8-  Sortir                                   **"
   echo "**************************************************"
   echo "   "
   echo -n "Entrez votre choix:"
   read choix

	case $choix in
	1)listCart
		notify-send 'opération réussite'
	./netmanage.sh;;
	2)configureCart
		notify-send 'opération réussite'
	./netmanage.sh;;
	3)upDownCart
		notify-send 'opération réussite'
	./netmanage.sh;;
	4)changeDNS
		notify-send 'opération réussite'
	./netmanage.sh;;
	5)changeMachineName
		notify-send 'opération réussite'
	./netmanage.sh;;
	6)restartService
		notify-send 'opération réussite'
	./netmanage.sh;;
	7)./main.sh;;
	8) exit 0;;
	esac





