/opt/zimbra/bin/zmprov gqu `zmhostname` | grep "@zimbra0.lab" | cut -d " " -f 3 | sed -e "s/ /,/g" | paste -sd+ - | bc

zmprov gqu `zmhostname` | grep "@zimbra0.lab" | cut -d " " -f 3 | sed -e "s/ /,/g" | paste -sd+ - | bc | awk '{ byte = $1 /1024 ; print byte " k";byte = $1 /1024/1024 ; print byte " MB"; byte =$1 /1024/1024**2 ; print byte " GB" }'

