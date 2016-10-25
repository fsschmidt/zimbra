#/bin/bash
#SCRIPT PARA IMPORTAR COS, CONTAS, NOMES ALTERNATIVOS E LISTAS DE DISTRIBUICAO DO ZIMBRA
#FABIO S. SCHMIDT - fabio_schmidt@hotmail.com - 02/04/2015
#TODO:

#IMPORTAR BASE LDAP NA ORDEM: COS, CONTAS, APELIDOS E LISTAS DE DISTRIBUIÇÃO

#DEFININDO VARIAVEIS DE AMBIENTE DO ZIMBRA
source ~/bin/zmshutil
zmsetvars

#OBTER INTERFACE DESEJADA E IP DO ZIMBRA PARA CONEXAO
IFACE="eth0"
IP=`/sbin/ifconfig $IFACE | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'`

ldapadd -c -x -H ldap://$IP -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f COS.ldif

ldapadd -c -x -H ldap://$IP -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f CONTAS.ldif

ldapadd -c -x -H ldap://$IP -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f APELIDOS.ldif

ldapadd -c -x -H ldap://$IP -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f LISTAS.ldif
