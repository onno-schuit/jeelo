#!/bin/bash
mysql -u root < reset_client.sql
rm /etc/apache2/conf/jeelos/testclient_debian_local
rm -r /home/jeelos/testclient.debian.local
