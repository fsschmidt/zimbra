#/bin/bash
#SCRIPT PARA IMPORTAR COS, CONTAS, NOMES ALTERNATIVOS E LISTAS DE DISTRIBUICAO DO ZIMBRA
#FABIO S. SCHMIDT
#TODO:

#IMPORTAR BASE LDAP NA ORDEM: COS, CONTAS, APELIDOS E LISTAS DE DISTRIBUIÇÃO

#DEFININDO VARIAVEIS DE AMBIENTE DO ZIMBRA
source ~/bin/zmshutil
zmsetvars
ZIMBRA_HOSTNAME=$zimbra_server_hostname

ldapadd -c -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f COS.ldif

ldapadd -c -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f CONTAS.ldif

ldapadd -c -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f APELIDOS.ldif

ldapadd -c -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -f LISTAS.ldif
