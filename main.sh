#!/bin/bash
clear;
echo "             "
echo "*************Menu Principale*******************"
echo "** 1 - Gérer les utilisateurs                **"
echo "** 2 - Gérer les taches planifiées           **"
echo "** 3 - Gérer les logs sytème                 **"
echo "** 4 - Gérer les réseaux                     **"
echo "** 5 - Sortir                                **"
echo "***********************************************"
echo "   "
echo -n "Entrez votre choix: "
read choix

case $choix in

1) ./usermanage.sh;;
2) ./cronmanage.sh;;
3) ./logmanage.sh;;
4) ./netmanage.sh;;
5) exit 0;;
esac



