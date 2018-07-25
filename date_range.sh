#!/bin/bash
# Script para exibir as mensagens (cabeçalhos) de uma caixa postal por dia, utilizando um período definido

rm -f date_range.txt

#data de inicio no padrao AAAA-MM-DD
start=2018-04-01
#data de termino no padrao AAAA-MM-DD
end=2018-07-24
#conta para auditoria
conta="fabio@respirandolinux.com.br"

while ! [[ $start > $end ]]; do
    echo $start >> date_range.txt
    start=$(date -d "$start + 1 day" +%F)
 done

for DATA in $(cat date_range.txt |  awk -v FS=- -v OFS=/ '{print $2,$3,$1}'); do
    echo Mensagens recebidas no dia $DATA
    echo "Data exibida no formato americano - MM/DD/AAAA"
    zmmailbox -v -z -m $conta -t 0 search --limit 1000 --types message  "* date:$DATA"
done

rm -f date_range.txt
