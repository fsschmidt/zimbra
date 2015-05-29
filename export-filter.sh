#!/bin/bash

clear

echo "Retrieve zimbra user name..."

USERS=`su - zimbra -c 'zmprov -l gaa | sort'`;

for ACCOUNT in $USERS; do
NAME=`echo $ACCOUNT`;
filter=`su - zimbra -c "zmprov ga $NAME zimbraMailSieveScript" > /tmp/$NAME`

sed -i -e "1d" /tmp/$NAME
sed 's/zimbraMailSieveScript: //g' /tmp/$NAME > filter/$NAME
rm /tmp/$NAME
echo "Export filter for $NAME..."
done
echo "All filter has been export successfully"
