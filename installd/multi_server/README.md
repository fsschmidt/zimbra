Repositório criado por Fabio S. Schmidt

Repositório para scripts "install.conf" de ambientes MULTI-SERVER para automatização da instalação do Zimbra.

*Utilizando Zimbra 8.7.1 NETWORK*

Exemplo: https://wiki.zimbra.com/wiki/Installing_Zimbra_Using_Chef

##############################################################################

*-mmr.conf

Arquitetura: LDAP MMR + MTA + MAILBOX + PROXY + LOGGER

LDAP MMR:

ldap1.dominio.local: primeiro ldap instalado - habilitado mmr
ldap2.dominio.local: segundo ldap instalado - informado que será o segundo master


#################################################################################



Referências:

https://wiki.zimbra.com/wiki/LDAP_Multi_Master_Replication (ldap multi-master)
