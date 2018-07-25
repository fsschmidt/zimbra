#!/bin/bash

start=2018-04-01
end=2018-07-24
conta="fabio@respirandolinux.com.br"

while ! [[ $start > $end ]]; do
    echo $start >> date_range.txt
            start=$(date -d "$start + 1 day" +%F)
                done

                for DATA in $(cat date_range.txt |  awk -v FS=- -v OFS=/ '{print $2,$3,$1}'); do
                 echo Mensagens recebidas no dia $DATA
                 echo "Data exibida no formato americano - MM/DD/YYYY"
                 zmmailbox -v -z -m $conta -t 0 search --limit 1000 --types message  "* date:$DATA"
                 done

                 rm -f date_range.txt
