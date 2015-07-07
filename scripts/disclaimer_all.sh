#!/bin/bash
for DOMAIN in $(zmprov gad); do
	echo Adicionando Disclaimers para o dominio: $DOMAIN
	zmprov md $DOMAIN zimbraAmavisDomainDisclaimerText "$(cat /opt/zimbra/postfix/conf/disclaimer.txt)"
	zmprov md $DOMAIN zimbraAmavisDomainDisclaimerHTML "$(cat /opt/zimbra/postfix/conf/disclaimer.html)"
done
