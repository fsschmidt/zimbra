#!/bin/bash
#FABIO S. SCHMIDT
#SCRIPT PARA EXPORTAR E IMPORTAR BLACKLISTS DO AMAVIS
#BASEADO EM: http://laurobmb.wordpress.com/2012/05/25/backup-and-restore-of-list-of-distribution-server-zimbra/
cont1=0
cont2=0
# RELACAO OBTIDA ATRAVES DO ZMPROV GAD
for i in $(cat /tmp/dominios.txt); do
/opt/zimbra/bin/zmprov gd $i amavisBlacklistSender | awk '{print $2}' > /tmp/blacklist_dominios.txt
cont1=$((cont1+1))
echo "####### $cont1 $i"
cont2=0
for j in $(cat /tmp/blacklist_dominios.txt); do
cont2=$((cont2+1))
echo -n "$cont2"
#GERA O SCRIPT QUE IRA EFETUAR AS INCLUSOES
echo "/opt/zimbra/bin/zmprov md $i +amavisBlacklistSender $j" >> /tmp/script_blacklist.sh
done
echo " "
echo " " >> /tmp/blacklist_dominios.txt
done
