#!/bin/bash
#CARREGA FUNCOES
. func.sh

clear
cat banner.txt

#AVISO E ORIENTACOES
#ALERTA LICENCA
#PROPAGANDA
test_exec()
{
read -p "Continuar (sim/nao)?" choice
	case "$choice" in
  		 y|Y|yes|s|S|sim ) echo "Iniciando utilitario";;
         n|N|no|nao ) exit 0 | echo "Execucao abortada pelo usuario";;
	     * ) testa_input ;;
    esac
}

#Confirma se o usuario deseja executar
test_exec

exit 0 

#Confirma se esta sendo executado com o usuario zimbra
Run_as_Zimbra

#DEFININDO VARIAVEIS DE AMBIENTE DO ZIMBRA
source ~/bin/zmshutil
zmsetvars

#TESTES PARA EXECUCAO DO UTILITARIO

#### COMANDOS
#TESTARLDAPSEARCH
COMANDO="ldapsearch"
Check_Command

#TESTAR ZMHOSTNAME
COMANDO="zmhostname"
Check_Command


#PODE CONTINUAR
#DEFININDO NOME DO SERVIDOR COM ZMHOSTNAME
ZIMBRA_HOSTNAME=`zmhostname`


####DIRETORIOS

DIRETORIO="/opt/zimbra"
Check_Directory

DESTINO="/tmp"

DIRETORIO="/tmp"
Check_Directory

#PODE CONTINUAR

#TESTANDO
#exit 0

 #EXPORTANDO CLASSES DE SERVICO
 echo "EXPORTANDO CLASSES DE SERVICO"
 ldapsearch -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -b '' -LLL "(objectclass=zimbraCOS)" > $DESTINO/COS.ldif

 #EXPORTANDO CONTAS
 echo "EXPORTANDO CONTAS"
 ldapsearch -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -b '' -LLL "(objectclass=zimbraAccount)" > $DESTINO/CONTAS.ldif

 #EXPORTANDO NOMES ALTERNATIVOS
 echo "EXPORTANDO NOMES ALTERNATIVOS"
 ldapsearch -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password  -b '' -LLL "(objectclass=zimbraAlias)" uid | grep ^uid | awk '{print $2}' > $DESTINO/lista_contas.ldif

 for MAIL in $(cat $DESTINO/lista_contas.ldif);
 do 
   ldapsearch -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -b '' -LLL "(&(uid=$MAIL)(objectclass=zimbraAlias))" > $DESTINO/$MAIL.tmp  	cat $DESTINO/alias/*.tmp > $DESTINO/APELIDOS.ldif
   done 

#EXPORTANDO LISTAS DE DISTRIBUICAO
echo "EXPORTANDO LISTAS DE DISTRIBUICAO"
ldapsearch -x -H ldap://$ZIMBRA_HOSTNAME -D uid=zimbra,cn=admins,cn=zimbra -w $zimbra_ldap_password -b '' -LLL "(objectclass=zimbraDistributionList)" > $DESTINO/LISTAS.ldif

##EXPORTANDO AS CAIXAS

RELACAO_CAIXAS=`zmprov -l gaa`

