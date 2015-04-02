#!/bin/bash
#EXPORTAR TABELA ZIMBRA E TABELAS MBOXGROUP
#FABIO S. SCHMIDT - fabio.schmidt@4linux.com.br - 02/04/2015
#TODO:

DEST="/tmp"

EXPORTAR=`mysql -u root --password=$mysql_root_password --socket=$mysql_socket -N information_schema -e "SELECT DISTINCT(TABLE_SCHEMA) FROM tables WHERE TABLE_SCHEMA LIKE 'mboxgroup%'"`

#EXPORTAR TABELA ZIMBRA
echo "EXPORTANDO TABELA ZIMBRA"
/opt/zimbra/mysql/bin/mysqldump --user=root --password=$mysql_root_password --socket=$mysql_socket   --compatible=ansi --single-transaction --flush-logs zimbra > $DEST/base_zimbra.sql

#EXPORTAR TABELAS MAILBOX

printf "TABELAS MAILBOX QUE SERAO EXPORTADAS: \n$EXPORTAR \n"
echo "EXPORTANDO TABELAS MAILBOX"
/opt/zimbra/mysql/bin/mysqldump --user=root --password=$mysql_root_password --socket=$mysql_socket --compatible=ansi --single-transaction --flush-logs --databases $(mysql -u root --password=$mysql_root_password --socket=$mysql_socket -N information_schema -e "SELECT DISTINCT(TABLE_SCHEMA) FROM tables WHERE TABLE_SCHEMA LIKE 'mboxgroup%'") > $DEST/bases_mboxgroup.sql
