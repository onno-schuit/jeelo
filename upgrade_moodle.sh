#!/bin/bash

# PLEASE NOTE THESE ASSUMPTIONS:
#
# - jeelo is apache webuser
# - you are root user
# - this script should be chmod 700
# - the new Moodle version resides in /home/jeelo/domains/jeelo.nl
# - backups are stored in /home/jeelo/domains/jeelo.nl/backups
# - all websites reside under /home/jeelo/domains/jeelo.nl/public_html
#
# - the database name is "jeelo_WEBROOT" or specified by you through the -d option

usageQuit()
{
  #echo "Usage: $0 -d database -w webroot -p password"
  echo "Usage: $0 -d database -w webroot"
  exit 1
}

DATABASE=
WEBROOT=
PASSWORD=
while getopts d:w:p: OPTION
do
     case $OPTION in
         d)
             DATABASE=$OPTARG
             ;;
         w)
             WEBROOT=$OPTARG
             ;;
         #p)
         #    PASSWORD=$OPTARG
         #    ;;
         ?)
             usageQuit
             exit
             ;;
     esac
done

echo "Please enter the database root password: "
read PASSWORD
 
if [[ -z $WEBROOT ]] || [[ -z $PASSWORD ]]
then
    usageQuit
    exit 1
fi
if [ -z "$DATABASE" ]; then
    DATABASE="jeelo_${WEBROOT}"
fi

#echo "DATABASE: ${DATABASE} / WEBROOT: ${WEBROOT} / PASSWORD: ${PASSWORD}"

echo -e "\nSTARTING UPGRADE"
cd /home/jeelo/domains/jeelo.nl/backups
mysqldump -uroot -p${PASSWORD} ${DATABASE} > ${DATABASE}.sql
echo -e "\nMade database backup"

cd /home/jeelo/domains/jeelo.nl/public_html
mv $WEBROOT ../backups/${WEBROOT}
echo -e "\nMade a backup of the webroot ${WEBROOT}"

cp -R ../moodle1917 ${WEBROOT}

rm -Rf ${WEBROOT}/theme
cp -R ../backups/${WEBROOT}/theme ${WEBROOT}/theme
echo -e "\nCopied the theme to the new Moodle version"

cp ../backups/${WEBROOT}/config.php ${WEBROOT}/config.php
echo -e "\nCopied config.php"

chown jeelo:jeelo -R ${WEBROOT}

mysql -uroot -p${PASSWORD} -e "ALTER DATABASE ${DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
echo -e "\nChanged database character set to utf8\nFINISHED UPGRADING"
