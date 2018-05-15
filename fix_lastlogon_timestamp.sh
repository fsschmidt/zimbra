#!/bin/bash

#LISTA DE CONTAS PARA CORRIGIR
ACCOUNTS_LIST="contas_corrigir.txt" 

#CARREGANDO VARIAVEIS DO AMBIENTE ZIMBRA
source ~/bin/zmshutil
zmsetvars

        for i in $( awk '//{print $1 }' $ACCOUNTS_LIST ); do
            TIMESTAMP=" $( grep $i $ACCOUNTS_LIST  | awk '{print $5" "$6 }' )" 
            NEW_TIMESTAMP="$( date -d "$TIMESTAMP" +%Y%m%d%H%M00.000Z )" 

            echo "Conta: $i Valor antigo: $TIMESTAMP Valor convertido: $NEW_TIMESTAMP" 
            ACCOUNT_DN=$( ldapsearch -x -H ldap://$zimbra_server_hostname -D $zimbra_ldap_userdn -w $zimbra_ldap_password -b '' -LLL "(&(!(zimbraIsSystemResource=TRUE))(mail=${i})(objectClass=zimbraAccount))" dn | sed 's/dn: //g' | sed '/^\s*$/d' | sed 's/^\ //g')

            ldapmodify -x -H  ldap://$zimbra_server_hostname -D $zimbra_ldap_userdn -w $zimbra_ldap_password <<EOF
            dn: $ACCOUNT_DN
            changetype: modify
            replace: zimbraLastLogonTimestamp
            zimbraLastLogonTimestamp: $NEW_TIMESTAMP
EOF
done
