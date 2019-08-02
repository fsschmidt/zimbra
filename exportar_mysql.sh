#!/bin/bash
#EXPORTAR TABELA ZIMBRA E TABELAS MBOXGROUP
#FABIO S. SCHMIDT - fabio@respirandolinux.com.br - 02/04/2015
# VALIDADO ZIMBRA 8.8.15 em 01/08/2019
#TODO:

DEST="/tmp"

#DEFININDO VARIAVEIS DE AMBIENTE DO ZIMBRA
source ~/bin/zmshutil
zmsetvars

EXPORTAR=`mysql -u root --password=$mysql_root_password --socket=$mysql_socket -N information_schema -e "SELECT DISTINCT(TABLE_SCHEMA) FROM tables WHERE TABLE_SCHEMA LIKE 'mboxgroup%'"`

#EXPORTAR TABELA ZIMBRA
echo "EXPORTANDO TABELA ZIMBRA"
mysqldump --user=root --password=$mysql_root_password --socket=$mysql_socket   --compatible=ansi --single-transaction --flush-logs zimbra > $DEST/base_zimbra.sql

#EXPORTAR TABELAS MAILBOX

printf "TABELAS MAILBOX QUE SERAO EXPORTADAS: \n$EXPORTAR \n"
echo "EXPORTANDO TABELAS MAILBOX"
mysqldump --user=root --password=$mysql_root_password --socket=$mysql_socket --compatible=ansi --single-transaction --flush-logs --databases $(mysql -u root --password=$mysql_root_password --socket=$mysql_socket -N information_schema -e "SELECT DISTINCT(TABLE_SCHEMA) FROM tables WHERE TABLE_SCHEMA LIKE 'mboxgroup%'") > $DEST/bases_mboxgroup.sql
