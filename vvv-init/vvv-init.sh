#!/bin/bash
# Init script for a development site with a monolithic Git repo
# v1.0

# Edit these variables to suit your porpoises
# -------------------------------------------

# Just a human readable description of this site
SITE_NAME="MVCSS & More"
# The name (to be) used by MySQL for the DB
DB_NAME="mvcss_wp"
# A bash array of search|replace pairs as strings, separated by spaces. 
# This is used to fixup a database from a production environment 
# being loaded into a dev environment.
SEARCH_REPLACE=( "site_name.wpengine.com|site_name.dev" "another_site_name.example.com|pearson.dev" )

# ----------------------------------------------------------------
# You should not need to edit below this point. Famous last words.

echo "Commencing $SITE_NAME setup"

# Reload SSH, to get it to notice the change to known_hosts
service ssh force-reload

# Make a database, if we don't already have one
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL PRIVILEGES ON $DB_NAME.* TO wp@localhost IDENTIFIED BY 'wp';"

DATA_IN_DB=`mysql -u root --password=root --skip-column-names -e "SHOW TABLES FROM $DB_NAME;"`
if [ "" == "$DATA_IN_DB" ]; then
	if [ ! -f initial-data.sql ]
	then
		echo "DATABASE NOT INSTALLED, add initial-data.sql file and run Vagrant provisioning again"
	else
		echo "Loading the database with lovely data"
		mysql -u root --password=root $DB_NAME < initial-data.sql
		for TO_SPLIT in ${SEARCH_REPLACE[@]}
		do
			SEARCH=`echo $TO_SPLIT |cut -d '|' -f1 `
			REPLACE=`echo $TO_SPLIT |cut -d '|' -f2 `
			echo "wp search-replace $SEARCH $REPLACE"
			wp search-replace $SEARCH $REPLACE
		done
	fi
	wp user create dev_admin dev_admin@example.com --role=administrator --user_pass=password
else
	echo "Database has data, skipping"
fi

# The Vagrant site setup script will restart Nginx for us

echo "$SITE_NAME site now installed, you may want to add the user uploaded files";
