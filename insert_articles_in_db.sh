#!/bin/sh

no_articles=5
rds_host="database-2.cshzicyg9d5b.us-east-1.rds.amazonaws.com"
name="admin"
password="ftOj45NRNkAGPeurcxn7"
db_name="test"
table_name="news"
port=3306

mysql -h $rds_host -P $port -u $name  -p$password -e "use test;delete from news"

for file in out/*; do
	cat $file | head -n $no_articles > tmp;
	while read p; do
	title=$(echo $p | sed -e "s/'//g")
	base=$(echo $(basename $file))
	date=$(date)
	insert_query="INSERT INTO $table_name (title,source,date) values('$title','$base','$date')"
	mysql -h $rds_host -P $port -u $name  -p$password -e "use test;$insert_query"
	done <tmp
	rm -rf tmp

done
