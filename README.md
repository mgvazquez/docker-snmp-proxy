# docker-snmp-proxy
SNMP Proxy for docker-compose Env


TO-DO
* Requerimientos
* Limitations
* como se usa
* ejemplos
* to-do


$ snmpget -v2c -c public localhost .1.3.6.1.2.1.1.5.0
iso.3.6.1.2.1.1.5.0 = STRING: "snmp-host01"
16:34:51 ✔ mgarcia@ofiuco:~$ snmpget -v2c -c public localhost .1.3.6.1.2.1.1.6.0
iso.3.6.1.2.1.1.6.0 = STRING: "Unknown (edit /etc/snmp/snmpd.conf)"
16:34:57 ✔ mgarcia@ofiuco:~$ snmpget -v2c -c public localhost .1.3.6.1.2.1.1.7.0
iso.3.6.1.2.1.1.7.0 = No Such Instance currently exists at this OID
16:35:00 ✔ mgarcia@ofiuco:~$




$ sudo docker-compose up
[sudo] password for mgarcia:
Starting snmp-proxy
Starting snmp-host3
Starting snmp-host1
Starting snmp-host2
Attaching to snmp-proxy, snmp-host3, snmp-host2, snmp-host1
snmp-proxy    | 2016-11-15 19:34:02,628 CRIT Supervisor running as root (no user in config file)
snmp-proxy    | 2016-11-15 19:34:02,629 INFO Included extra file "/etc/supervisord.d/docker-gen.conf" during parsing
snmp-proxy    | 2016-11-15 19:34:02,629 INFO Included extra file "/etc/supervisord.d/snmpd.conf" during parsing
snmp-proxy    | 2016-11-15 19:34:02,635 INFO RPC interface 'supervisor' initialized
snmp-proxy    | 2016-11-15 19:34:02,635 CRIT Server 'unix_http_server' running without any HTTP authentication checking
snmp-proxy    | 2016-11-15 19:34:02,635 INFO supervisord started with pid 1
snmp-host3    | error finding row index in _ifXTable_container_row_restore
snmp-host3    | NET-SNMP version 5.7.2
snmp-host2    | error finding row index in _ifXTable_container_row_restore
snmp-host2    | NET-SNMP version 5.7.2
snmp-host1    | error finding row index in _ifXTable_container_row_restore
snmp-host1    | NET-SNMP version 5.7.2
snmp-proxy    | 2016-11-15 19:34:03,637 INFO spawned: 'snmpd' with pid 17
snmp-proxy    | 2016-11-15 19:34:03,639 INFO spawned: 'docker-gen' with pid 18
snmp-proxy    | 2016-11-15 19:34:03,772 INFO waiting for snmpd to stop
snmp-proxy    | 2016-11-15 19:34:03,776 INFO stopped: snmpd (exit status 0)
snmp-proxy    | 2016-11-15 19:34:03,779 INFO spawned: 'snmpd' with pid 27
snmp-proxy    | 2016-11-15 19:34:04,809 INFO success: snmpd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
snmp-proxy    | 2016-11-15 19:34:04,809 INFO success: docker-gen entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
snmp-host1    | Received SNMP packet(s) from UDP: [172.18.0.2]:58390->[172.18.0.3]:161
snmp-host1    |   GET message
snmp-host1    |     -- SNMPv2-MIB::sysName.0
snmp-host2    | Received SNMP packet(s) from UDP: [172.18.0.2]:45859->[172.18.0.5]:161
snmp-host2    |   GET message
snmp-host2    |     -- SNMPv2-MIB::sysLocation.0
snmp-host3    | Received SNMP packet(s) from UDP: [172.18.0.2]:53948->[172.18.0.4]:161
snmp-host3    |   GET message
snmp-host3    |     -- SNMPv2-MIB::sysServices.0
