source ~/bin/zmshutil; zmsetvars

ldapwhoami -x -D uid=zmamavis,cn=appaccts,cn=zimbra -H ldap://`zmhostname`:389 -w $ldap_amavis_password

ldapwhoami -x -D uid=zmbes-searcher,cn=appaccts,cn=zimbra -H ldap://`zmhostname`:389 -w $ldap_bes_searcher_password

ldapwhoami -x -D uid=zmnginx,cn=appaccts,cn=zimbra -H ldap://`zmhostname`:389 -w $ldap_nginx_password  

ldapwhoami -x -D uid=zmpostfix,cn=appaccts,cn=zimbra -H ldap://`zmhostname`:389 -w $ldap_postfix_password

ldapwhoami -x -D cn=config -H ldap://`zmhostname`:389 -w $ldap_root_password

ldapwhoami -x -D uid=zimbra,cn=admins,cn=zimbra -H ldap://`zmhostname`:389 -w $zimbra_ldap_password

ldapwhoami -x -D uid=zmreplica,cn=admins,cn=zimbra -H ldap://`zmhostname`:389 -w $ldap_replication_password
