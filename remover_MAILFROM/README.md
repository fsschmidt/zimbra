# Criado por Fabio Soares Schmidt <fabio@respirandolinux.com.br>
# Site: https://respirandolinux.com.br

Este patch foi criado para auxiiliar no processo de conformidade do cliente WEB Zimbra com políticas de segurança da informação, desabilitando a opção que permite alterar o nome de exibição (MAIL FROM) no envio das mensagens.

Embora o cliente WEB do Zimbra restringa a alteração do E-mail de origem, inibindo que seja forjado o rementente, convém que o nome de exibição também seja protegido, inibindo assim completamente a possibilidade de forjar remetentes ou identidades ao enviar mensagens.

Limitações:

- Compatível somente com última versão do Zimbra (No momento: 8.7.1) - Funciona para ambas as edições (Open Source e Network);
- Como o Javascript é alterado, a alteração é aplicada para todas as contas, não sendo possível aplicar exceções;
- Necessário limpar o cache dos navegadores.
