/opt/zimbra/bin/zmprov gqu `zmhostname` | grep "@zimbra0.lab" | cut -d " " -f 3 | sed -e "s/ /,/g" | paste -sd+ - | bc
