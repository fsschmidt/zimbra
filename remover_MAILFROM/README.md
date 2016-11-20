# Criado por Fabio Soares Schmidt <fabio@respirandolinux.com.br>
# Site: https://respirandolinux.com.br

Este patch foi criado para auxiiliar no processo de conformidade do cliente WEB Zimbra com políticas de segurança da informação, desabilitando as opções que permitem alterar o nome de exibição (MAIL FROM) e definir um endereço de resposta diferente (REPLY TO) no envio das mensagens:

![alt tag](https://respirandolinux.files.wordpress.com/2016/11/zimbra-preferc3aancias-contas-google-chrome.jpg)

Embora o cliente WEB do Zimbra limite a alteração do E-mail de origem, inibindo que seja forjado o remetente, convém que o nome de exibição também seja protegido, inibindo assim completamente a possibilidade de forjar remetentes ou identidades ao enviar mensagens. Bloqueando a opção de definir um endereço de resposta diferente, também é inibida a ação de direcionar mensagens indevidamente.

Limitações:

- Compatível somente com última versão do Zimbra (No momento: 8.7.1) - Funciona para ambas as edições (Open Source e Network);
- Como o Javascript é modificado, a alteração é aplicada para todas as contas, não sendo possível aplicar exceções;
- Necessário limpar o cache dos navegadores.

Interface após aplicação do patch:

![alt tag](https://respirandolinux.files.wordpress.com/2016/11/prtscr-capture.jpg)


Convém que a política aplicada com este PATCH seja combinada com outras ações, como inibir o acesso à contas externas, personagens e definir um endereço de encaminhamento:

![alt tag](https://respirandolinux.files.wordpress.com/2016/11/console-de-administrac3a7c3a3o-do-zimbra-gerenciar-contas-google-chrome.jpg)

# Aplicando o PATCH
(Extrair os arquivos deste patch em /tmp)

su - zimbra

cd /opt/zimbra/jetty/webapps/zimbra/js

md5sum PreferencesCore_all.js >  /tmp/PreferencesCore_all.md5

md5sum PreferencesCore_all.js.zgz >  /tmp/PreferencesCore_all_zgz.md5

(Prosseguir se as validaçãos dos MD5 forem positivas)

gunzip -S zgz PreferencesCore_all.js.zgz

patch -p0 PreferencesCore_all.js. < /tmp/remover_MAILFROM_JS.patch

patch -p0 PreferencesCore_all.js < /tmp/remover_MAILFROM.patch

gzip -S zgz PreferencesCore_all.js.

(Não é necessário reiniciar nenhum servidor do Zimbra)
