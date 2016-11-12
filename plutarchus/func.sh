#!/bin/bash

#FUNCOES PARA O UTILITARIO

##
Check_Directory()
{

if [ ! -d "$DIRETORIO" ]; then
	echo "O diretorio $DIRETORIO nao existe, abortando execucao."
	exit 1 
	else
	echo "Diretorio $DIRETORIO encontrado."

fi
}

##
Check_Command()
{
   type $COMANDO >/dev/null 2>/dev/null
if [ $? == 0 ]
   then
   echo "comando $COMANDO existente."
   else
   echo "O comando $COMANDO nao foi encontrado, abortando execucao."
   exit 1
fi

}


##
Run_as_Zimbra()
{

if [ "$(whoami)" == "zimbra" ]; then
      echo "Executando como Zimbra."
   else
      echo "Esse comando deve ser executado com o usuario Zimbra, abortando execucao."
	  exit 1 
fi
}

Replace_Hostname()
{
sed -i s/$OLD_HOSTNAME/$NEW_HOSTNAME/g $ARQUIVOS_CONTA.ldif
}
